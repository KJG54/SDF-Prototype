param(
  [switch]$Staged,
  [switch]$All,
  [string[]]$Path,
  [switch]$WarningsAsFailures
)

$ErrorActionPreference = "Stop"

if ($Staged -and $All) {
  Write-Error "Use either -Staged or -All, not both."
  exit 2
}

try {
  $repoRoot = (git rev-parse --show-toplevel).Trim()
} catch {
  $repoRoot = (Get-Location).Path
}

Push-Location $repoRoot

$results = @()
$selected = @{}
$jsonCache = @{}
$contentCache = @{}
$supportedPhaseStatuses = @(
  "pending",
  "in-progress",
  "blocked",
  "ready-for-gate",
  "approved",
  "deferred"
)

function Add-Result {
  param(
    [string]$Level,
    [string]$File,
    [string]$Message
  )

  $script:results += [pscustomobject]@{
    Level = $Level
    File = $File
    Message = $Message
  }
}

function ConvertTo-RepoRelative {
  param([string]$Value)

  if ([string]::IsNullOrWhiteSpace($Value)) {
    return $null
  }

  if ([System.IO.Path]::IsPathRooted($Value)) {
    $fullPath = [System.IO.Path]::GetFullPath($Value)
  } else {
    $fullPath = [System.IO.Path]::GetFullPath((Join-Path $repoRoot $Value))
  }

  $normalizedFullPath = $fullPath -replace "\\", "/"
  $normalizedRepoRoot = $repoRoot -replace "\\", "/"

  if ($normalizedFullPath.StartsWith($normalizedRepoRoot, [System.StringComparison]::OrdinalIgnoreCase)) {
    $relative = $normalizedFullPath.Substring($normalizedRepoRoot.Length).TrimStart("\", "/")
  } else {
    $relative = $Value
  }

  return ($relative -replace "\\", "/")
}

function Should-Skip {
  param([string]$RelativePath)

  if ($RelativePath -match '(^|/)(\.git|node_modules|dist|build|\.next|\.venv|\.conda|__pycache__)(/|$)') {
    return $true
  }

  if ($RelativePath -match '^projects/[^/]+/workspace/') {
    return $true
  }

  if ($RelativePath -match '^memory/vault/') {
    return $true
  }

  return $false
}

function Add-SelectedFile {
  param([string]$RelativePath)

  $normalized = ConvertTo-RepoRelative $RelativePath
  if ([string]::IsNullOrWhiteSpace($normalized)) {
    return
  }

  if (Should-Skip $normalized) {
    return
  }

  $extension = [System.IO.Path]::GetExtension($normalized).ToLowerInvariant()
  if ($extension -ne ".json" -and $extension -ne ".md") {
    return
  }

  $script:selected[$normalized] = $true
}

function Read-RepoText {
  param([string]$RelativePath)

  if ($script:contentCache.ContainsKey($RelativePath)) {
    return $script:contentCache[$RelativePath]
  }

  $content = $null

  if ($Staged) {
    $gitOutput = git show ":$RelativePath" 2>$null
    if ($LASTEXITCODE -eq 0) {
      $content = ($gitOutput -join "`n")
    }
  }

  if ($null -eq $content -and (Test-Path -LiteralPath $RelativePath)) {
    $content = Get-Content -Raw -LiteralPath $RelativePath
  }

  $script:contentCache[$RelativePath] = $content
  return $content
}

function Read-RepoJson {
  param([string]$RelativePath)

  if ($script:jsonCache.ContainsKey($RelativePath)) {
    return $script:jsonCache[$RelativePath]
  }

  $content = Read-RepoText $RelativePath
  if ($null -eq $content) {
    return $null
  }

  try {
    $json = $content | ConvertFrom-Json -ErrorAction Stop
    $script:jsonCache[$RelativePath] = $json
    return $json
  } catch {
    Add-Result "fail" $RelativePath "JSON does not parse: $($_.Exception.Message)"
    return $null
  }
}

function Has-Property {
  param(
    [object]$Object,
    [string]$Name
  )

  if ($null -eq $Object) {
    return $false
  }

  return $null -ne $Object.PSObject.Properties[$Name]
}

function Is-ArtifactPath {
  param([string]$RelativePath)

  return $RelativePath -match '^(templates/artifacts|projects/[^/]+/artifacts)/'
}

function Is-ProjectStatePath {
  param([string]$RelativePath)

  return $RelativePath -match '^(templates/projects|projects/[^/]+)/(STATUS\.md|status\.json|PROJECT-CHECKLIST\.md|project-checklist\.json)$'
}

function Get-PairMate {
  param([string]$RelativePath)

  $directory = Split-Path $RelativePath -Parent
  $leaf = Split-Path $RelativePath -Leaf
  $extension = [System.IO.Path]::GetExtension($leaf).ToLowerInvariant()
  $stem = [System.IO.Path]::GetFileNameWithoutExtension($leaf)

  if (Is-ArtifactPath $RelativePath) {
    if ($extension -eq ".json") {
      return (($directory + "/" + $stem + ".md") -replace "\\", "/")
    }
    if ($extension -eq ".md") {
      return (($directory + "/" + $stem + ".json") -replace "\\", "/")
    }
  }

  if (Is-ProjectStatePath $RelativePath) {
    if ($leaf -eq "STATUS.md") {
      return (($directory + "/status.json") -replace "\\", "/")
    }
    if ($leaf -eq "status.json") {
      return (($directory + "/STATUS.md") -replace "\\", "/")
    }
    if ($leaf -eq "PROJECT-CHECKLIST.md") {
      return (($directory + "/project-checklist.json") -replace "\\", "/")
    }
    if ($leaf -eq "project-checklist.json") {
      return (($directory + "/PROJECT-CHECKLIST.md") -replace "\\", "/")
    }
  }

  return $null
}

function Get-ArtifactIdFromFile {
  param([string]$RelativePath)

  $stem = [System.IO.Path]::GetFileNameWithoutExtension($RelativePath)
  $parts = $stem -split "-"
  if ($parts.Count -ge 2 -and $parts[1] -match '^\d{3,}$') {
    return "$($parts[0])-$($parts[1])"
  }

  return $null
}

function Is-LegacyProjectWrapperGap {
  param([string]$RelativePath)

  return $RelativePath -match '^projects/[^/]+/(STATUS\.md|status\.json|PROJECT-CHECKLIST\.md|project-checklist\.json)$'
}

function Validate-JsonShape {
  param([string]$RelativePath)

  $extension = [System.IO.Path]::GetExtension($RelativePath).ToLowerInvariant()
  if ($extension -ne ".json") {
    return
  }

  $json = Read-RepoJson $RelativePath
  if ($null -eq $json) {
    return
  }

  if (Is-ArtifactPath $RelativePath) {
    $expectedId = Get-ArtifactIdFromFile $RelativePath
    if ($null -ne $expectedId) {
      if (-not (Has-Property $json "id")) {
        Add-Result "fail" $RelativePath "Artifact JSON is missing id '$expectedId'."
      } elseif ([string]$json.id -ne $expectedId) {
        Add-Result "fail" $RelativePath "Artifact id '$($json.id)' does not match filename id '$expectedId'."
      }
    }

    $isTemplate = $RelativePath -match '^templates/artifacts/'
    if ($isTemplate -and -not (Has-Property $json "type")) {
      Add-Result "fail" $RelativePath "Artifact template JSON is missing a type field."
    }

    if ($expectedId -like "GATE-*") {
      foreach ($field in @("phase", "gate_status", "markdown_json_alignment_checked", "human_approval")) {
        if (-not (Has-Property $json $field)) {
          Add-Result "fail" $RelativePath "Phase gate JSON is missing required field '$field'."
        }
      }

      if (-not (Has-Property $json "security_privacy_check")) {
        if ($RelativePath -match '^projects/') {
          Add-Result "warning" $RelativePath "Phase gate is missing security_privacy_check; migrate this legacy project artifact before using it as a future gate model."
        } else {
          Add-Result "fail" $RelativePath "Phase gate template is missing security_privacy_check."
        }
      }
    }

    if ($expectedId -like "REVIEW-*" -and -not (Has-Property $json "security_privacy_review")) {
      Add-Result "fail" $RelativePath "Review JSON is missing security_privacy_review."
    }
  }

  if ($RelativePath -match '(^|/)status\.json$') {
    foreach ($field in @("project_name", "slug", "state", "current_phase", "open_questions", "next_step", "current_phase_gate", "blocking_issues")) {
      if (-not (Has-Property $json $field)) {
        Add-Result "fail" $RelativePath "Project status JSON is missing required field '$field'."
      }
    }
  }

  if ($RelativePath -match '(^|/)project-checklist\.json$') {
    foreach ($field in @("current_phase", "phases", "open_questions", "human_actions", "deferred_items")) {
      if (-not (Has-Property $json $field)) {
        Add-Result "fail" $RelativePath "Project checklist JSON is missing required field '$field'."
      }
    }

    if (Has-Property $json "phases") {
      foreach ($phase in @($json.phases)) {
        if (-not (Has-Property $phase "status")) {
          Add-Result "fail" $RelativePath "A checklist phase is missing status."
        } elseif ($supportedPhaseStatuses -notcontains [string]$phase.status) {
          Add-Result "fail" $RelativePath "Unsupported checklist phase status '$($phase.status)'."
        }
      }
    }
  }
}

function Validate-Pair {
  param(
    [string]$Left,
    [string]$Right
  )

  $leftExists = $null -ne (Read-RepoText $Left)
  $rightExists = $null -ne (Read-RepoText $Right)

  if (-not $leftExists -or -not $rightExists) {
    $missing = $Right
    if (-not $leftExists) {
      $missing = $Left
    }

    if (Is-LegacyProjectWrapperGap $missing) {
      Add-Result "warning" $missing "Legacy/local project wrapper is missing a paired status or checklist file."
    } else {
      Add-Result "fail" $missing "Missing paired artifact file."
    }
    return
  }

  $jsonFile = $null
  $markdownFile = $null
  if ([System.IO.Path]::GetExtension($Left).ToLowerInvariant() -eq ".json") {
    $jsonFile = $Left
    $markdownFile = $Right
  } else {
    $jsonFile = $Right
    $markdownFile = $Left
  }

  $json = Read-RepoJson $jsonFile
  $markdown = Read-RepoText $markdownFile
  if ($null -eq $json -or $null -eq $markdown) {
    return
  }

  if (Has-Property $json "id") {
    if ($markdown -notmatch [regex]::Escape([string]$json.id)) {
      Add-Result "warning" $markdownFile "Markdown does not mention JSON id '$($json.id)'."
    }
  }

  if ($jsonFile -match 'GATE-[^/]+\.json$') {
    if ($markdown -notmatch 'Security\s*/\s*Privacy') {
      Add-Result "warning" $markdownFile "Phase gate Markdown does not include a Security / Privacy section."
    }

    if (Has-Property $json "gate_status") {
      if ($markdown -notmatch [regex]::Escape([string]$json.gate_status)) {
        Add-Result "warning" $markdownFile "Markdown does not mention gate_status '$($json.gate_status)'."
      }
    }

    if (Has-Property $json "human_approval") {
      if ($markdown -notmatch [regex]::Escape([string]$json.human_approval)) {
        Add-Result "warning" $markdownFile "Markdown does not mention human_approval '$($json.human_approval)'."
      }
    }
  }
}

function Validate-ProjectStateAlignment {
  param([string]$Directory)

  $statusPath = (($Directory + "/status.json") -replace "\\", "/")
  $checklistPath = (($Directory + "/project-checklist.json") -replace "\\", "/")

  if ($null -eq (Read-RepoText $statusPath) -or $null -eq (Read-RepoText $checklistPath)) {
    return
  }

  $status = Read-RepoJson $statusPath
  $checklist = Read-RepoJson $checklistPath

  if ($null -eq $status -or $null -eq $checklist) {
    return
  }

  if ((Has-Property $status "current_phase") -and (Has-Property $checklist "current_phase")) {
    if ([string]$status.current_phase -ne [string]$checklist.current_phase) {
      Add-Result "warning" $statusPath "status.json current_phase '$($status.current_phase)' differs from project-checklist.json current_phase '$($checklist.current_phase)'."
    }
  }
}

if ($Path -and $Path.Count -gt 0) {
  foreach ($inputPath in $Path) {
    if (Test-Path -LiteralPath $inputPath -PathType Container) {
      Get-ChildItem -LiteralPath $inputPath -Recurse -File |
        ForEach-Object { Add-SelectedFile $_.FullName }
    } else {
      Add-SelectedFile $inputPath
    }
  }
} elseif ($All) {
  foreach ($root in @("templates", "projects")) {
    if (Test-Path -LiteralPath $root) {
      Get-ChildItem -LiteralPath $root -Recurse -File |
        ForEach-Object { Add-SelectedFile $_.FullName }
    }
  }

  if (Test-Path -LiteralPath "templates/projects") {
    foreach ($stateFile in @("STATUS.md", "status.json", "PROJECT-CHECKLIST.md", "project-checklist.json")) {
      Add-SelectedFile (Join-Path "templates/projects" $stateFile)
    }
  }

  if (Test-Path -LiteralPath "projects") {
    Get-ChildItem -LiteralPath "projects" -Directory |
      ForEach-Object {
        foreach ($stateFile in @("STATUS.md", "status.json", "PROJECT-CHECKLIST.md", "project-checklist.json")) {
          Add-SelectedFile (Join-Path $_.FullName $stateFile)
        }
      }
  }
} else {
  $Staged = $true
  $stagedFiles = git diff --cached --name-only --diff-filter=ACMR
  foreach ($file in @($stagedFiles)) {
    Add-SelectedFile $file
  }
}

foreach ($file in @($selected.Keys)) {
  $mate = Get-PairMate $file
  if ($null -ne $mate) {
    Add-SelectedFile $mate
  }
}

if ($selected.Count -eq 0) {
  Write-Output "Artifact validation: no files to validate."
  Pop-Location
  exit 0
}

$pairKeys = @{}
foreach ($file in @($selected.Keys)) {
  Validate-JsonShape $file

  $mate = Get-PairMate $file
  if ($null -ne $mate) {
    $ordered = @($file, $mate) | Sort-Object
    $pairKey = $ordered -join "|"
    $pairKeys[$pairKey] = $ordered
  }
}

foreach ($pair in @($pairKeys.Values)) {
  Validate-Pair $pair[0] $pair[1]
}

$stateDirectories = @{}
foreach ($file in @($selected.Keys)) {
  if ($file -match '^(templates/projects|projects/[^/]+)/(status\.json|project-checklist\.json)$') {
    $stateDirectories[(Split-Path $file -Parent) -replace "\\", "/"] = $true
  }
}

foreach ($directory in @($stateDirectories.Keys)) {
  Validate-ProjectStateAlignment $directory
}

$failCount = @($results | Where-Object { $_.Level -eq "fail" }).Count
$warningCount = @($results | Where-Object { $_.Level -eq "warning" }).Count

if ($results.Count -gt 0) {
  Write-Output "Artifact validation findings:"
  $results |
    Sort-Object Level, File, Message |
    Format-Table -AutoSize -Wrap
}

if ($failCount -gt 0 -or ($WarningsAsFailures -and $warningCount -gt 0)) {
  Write-Output "Artifact validation failed. Files checked: $($selected.Count). Failures: $failCount. Warnings: $warningCount."
  Pop-Location
  exit 1
}

Write-Output "Artifact validation passed. Files checked: $($selected.Count). Warnings: $warningCount."
Pop-Location
