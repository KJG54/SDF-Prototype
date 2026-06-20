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

function Get-NormalizedStringArray {
  param(
    [object]$Object,
    [string]$Name
  )

  if (-not (Has-Property $Object $Name)) {
    return @()
  }

  return @($Object.($Name) | ForEach-Object { ([string]$_).Trim() } | Where-Object { $_ -ne "" } | Sort-Object)
}

function Test-StringArraysEqual {
  param(
    [string[]]$Left,
    [string[]]$Right
  )

  $leftValues = @($Left | Sort-Object)
  $rightValues = @($Right | Sort-Object)

  if ($leftValues.Count -ne $rightValues.Count) {
    return $false
  }

  for ($index = 0; $index -lt $leftValues.Count; $index++) {
    if ($leftValues[$index] -ne $rightValues[$index]) {
      return $false
    }
  }

  return $true
}

function Test-PhaseMatchesCurrent {
  param(
    [object]$Phase,
    [string]$CurrentPhase
  )

  if ($null -eq $Phase -or [string]::IsNullOrWhiteSpace($CurrentPhase)) {
    return $false
  }

  $normalizedCurrent = $CurrentPhase.Trim()
  $phaseId = ""
  $phaseName = ""

  if (Has-Property $Phase "id") {
    $phaseId = ([string]$Phase.id).Trim()
  }
  if (Has-Property $Phase "name") {
    $phaseName = ([string]$Phase.name).Trim()
  }

  if ($phaseId -ne "" -and $normalizedCurrent -eq $phaseId) {
    return $true
  }
  if ($phaseName -ne "" -and $normalizedCurrent -eq $phaseName) {
    return $true
  }
  if ($phaseName -ne "" -and $normalizedCurrent -like "*$phaseName*") {
    return $true
  }

  return $false
}

function Find-ChecklistPhase {
  param(
    [object]$Checklist,
    [string]$CurrentPhase
  )

  if (-not (Has-Property $Checklist "phases")) {
    return $null
  }

  foreach ($phase in @($Checklist.phases)) {
    if (Test-PhaseMatchesCurrent $phase $CurrentPhase) {
      return $phase
    }
  }

  return $null
}

function Test-JsonType {
  param(
    [object]$Value,
    [string]$ExpectedType
  )

  switch ($ExpectedType) {
    "object" {
      return ($null -ne $Value -and $Value -is [pscustomobject])
    }
    "array" {
      return ($null -ne $Value -and $Value -is [System.Array])
    }
    "string" {
      return ($null -ne $Value -and $Value -is [string])
    }
    "boolean" {
      return ($null -ne $Value -and $Value -is [bool])
    }
    "number" {
      return ($null -ne $Value -and ($Value -is [int] -or $Value -is [long] -or $Value -is [double] -or $Value -is [decimal]))
    }
    "integer" {
      return ($null -ne $Value -and ($Value -is [int] -or $Value -is [long]))
    }
    "null" {
      return $null -eq $Value
    }
    default {
      return $true
    }
  }
}

function Get-SchemaTypeList {
  param([object]$Schema)

  if (-not (Has-Property $Schema "type")) {
    return @()
  }

  if ($Schema.type -is [System.Array]) {
    return @($Schema.type)
  }

  return @([string]$Schema.type)
}

function Format-SchemaPath {
  param(
    [string]$Parent,
    [string]$Child
  )

  if ([string]::IsNullOrWhiteSpace($Parent)) {
    return $Child
  }

  if ($Child -match '^\[') {
    return "$Parent$Child"
  }

  return "$Parent.$Child"
}

function Validate-ValueAgainstSchema {
  param(
    [object]$Value,
    [object]$Schema,
    [string]$RelativePath,
    [string]$JsonPath,
    [string]$Severity = "fail"
  )

  if ($null -eq $Schema) {
    return
  }

  $types = Get-SchemaTypeList $Schema
  if ($types.Count -gt 0) {
    $matchesType = $false
    foreach ($type in $types) {
      if (Test-JsonType $Value ([string]$type)) {
        $matchesType = $true
        break
      }
    }

    if (-not $matchesType) {
      Add-Result $Severity $RelativePath "Schema mismatch at '$JsonPath': expected type '$($types -join "|")'."
      return
    }
  }

  if (Has-Property $Schema "enum") {
    $allowed = @($Schema.enum | ForEach-Object { [string]$_ })
    if ($allowed -notcontains [string]$Value) {
      Add-Result $Severity $RelativePath "Schema mismatch at '$JsonPath': value '$Value' is not one of '$($allowed -join ", ")'."
      return
    }
  }

  if ($Value -is [pscustomobject]) {
    if (Has-Property $Schema "required") {
      foreach ($requiredField in @($Schema.required)) {
        if (-not (Has-Property $Value ([string]$requiredField))) {
          Add-Result $Severity $RelativePath "Schema mismatch at '$JsonPath': missing required field '$requiredField'."
        }
      }
    }

    if (Has-Property $Schema "properties") {
      foreach ($property in @($Schema.properties.PSObject.Properties)) {
        if (Has-Property $Value $property.Name) {
          Validate-ValueAgainstSchema $Value.($property.Name) $property.Value $RelativePath (Format-SchemaPath $JsonPath $property.Name) $Severity
        }
      }
    }
  }

  if ($Value -is [System.Array] -and (Has-Property $Schema "items")) {
    for ($index = 0; $index -lt $Value.Count; $index++) {
      Validate-ValueAgainstSchema $Value[$index] $Schema.items $RelativePath (Format-SchemaPath $JsonPath "[$index]") $Severity
    }
  }
}

function Get-SchemaPathForJson {
  param([string]$RelativePath)

  if ($RelativePath -match '(^|/)status\.json$') {
    return "contracts/schemas/project-status.schema.json"
  }

  if ($RelativePath -match '(^|/)project-checklist\.json$') {
    return "contracts/schemas/project-checklist.schema.json"
  }

  if ($RelativePath -match '(^|/)GATE-[^/]+\.json$') {
    return "contracts/schemas/phase-gate.schema.json"
  }

  if ($RelativePath -match '(^|/)SUMMARY-[^/]+\.json$') {
    return "contracts/schemas/phase-summary.schema.json"
  }

  $leaf = Split-Path $RelativePath -Leaf
  if ($leaf -cmatch '^ACTION-[^/]+\.json$') {
    return "contracts/schemas/human-action.schema.json"
  }
  if ($leaf -cmatch '^APPROVAL-[^/]+\.json$') {
    return "contracts/schemas/approval.schema.json"
  }
  if ($leaf -cmatch '^REQ-[^/]+\.json$') {
    return "contracts/schemas/requirements.schema.json"
  }
  if ($leaf -cmatch '^ARCH-[^/]+\.json$') {
    return "contracts/schemas/architecture.schema.json"
  }
  if ($leaf -cmatch '^ENV-[^/]+\.json$') {
    return "contracts/schemas/environment-setup.schema.json"
  }
  if ($leaf -cmatch '^PLAN-[^/]+\.json$') {
    return "contracts/schemas/build-plan.schema.json"
  }
  if ($leaf -cmatch '^SCAFFOLD-[^/]+\.json$') {
    return "contracts/schemas/scaffold-notes.schema.json"
  }
  if ($leaf -cmatch '^IMPL-[^/]+\.json$') {
    return "contracts/schemas/implementation-notes.schema.json"
  }
  if ($leaf -cmatch '^VERIFY-[^/]+\.json$') {
    return "contracts/schemas/verification-report.schema.json"
  }
  if ($leaf -cmatch '^REVIEW-[^/]+\.json$') {
    return "contracts/schemas/review-report.schema.json"
  }
  if ($leaf -cmatch '^SHIP-[^/]+\.json$') {
    return "contracts/schemas/shipping-plan.schema.json"
  }
  if ($leaf -cmatch '^MEMORY-[^/]+\.json$') {
    return "contracts/schemas/project-memory-packet.schema.json"
  }
  if ($leaf -cmatch '^TASK-[^/]+\.json$') {
    return "contracts/schemas/task-record.schema.json"
  }
  if ($leaf -cmatch '^OPERATING-[^/]+\.json$') {
    return "contracts/schemas/project-operating-model.schema.json"
  }

  if (Is-ArtifactPath $RelativePath) {
    return "contracts/schemas/artifact-base.schema.json"
  }

  return $null
}

function Is-LegacyProjectSchemaGap {
  param([string]$RelativePath)

  if ($RelativePath -notmatch '^projects/([^/]+)/') {
    return $false
  }

  $projectRoot = "projects/$($Matches[1])"
  $status = Read-RepoJson "$projectRoot/status.json"

  if ($null -eq $status) {
    return $false
  }

  if ((Has-Property $status "schema_profile") -and ($status.schema_profile -eq "legacy")) {
    return $true
  }

  if (-not (Has-Property $status "checklist_files")) {
    return $true
  }

  return $false
}

function Validate-JsonSchema {
  param(
    [string]$RelativePath,
    [object]$Json
  )

  $schemaPath = Get-SchemaPathForJson $RelativePath
  if ($null -eq $schemaPath) {
    return
  }

  $schema = Read-RepoJson $schemaPath
  if ($null -eq $schema) {
    Add-Result "fail" $RelativePath "Schema '$schemaPath' could not be loaded."
    return
  }

  if (Is-LegacyProjectSchemaGap $RelativePath) {
    if (($RelativePath -match '(^|/)status\.json$') -and (-not (Has-Property $Json "schema_profile"))) {
      Add-Result "warning" $RelativePath "Legacy project schema validation skipped; migrate this project before using it as a future schema model."
    }
    return
  }

  Validate-ValueAgainstSchema $Json $schema $RelativePath "$" "fail"
}

function Validate-PhaseGateSemantics {
  param(
    [string]$RelativePath,
    [object]$Gate
  )

  if ($null -eq $Gate) {
    return
  }

  $gateStatus = ""
  $humanApproval = ""

  if (Has-Property $Gate "gate_status") {
    $gateStatus = ([string]$Gate.gate_status).ToLowerInvariant()
  }
  if (Has-Property $Gate "human_approval") {
    $humanApproval = ([string]$Gate.human_approval).ToLowerInvariant()
  }

  $supportedGateStatuses = @("pending", "passed", "blocked", "deferred-with-approval")
  if ($gateStatus -ne "" -and $supportedGateStatuses -notcontains $gateStatus) {
    Add-Result "warning" $RelativePath "Phase gate uses unsupported gate_status '$($Gate.gate_status)'."
  }

  if ($humanApproval -eq "approved" -and $gateStatus -eq "pending") {
    Add-Result "fail" $RelativePath "Phase gate cannot be pending when human_approval is approved."
  }

  if ($gateStatus -eq "passed") {
    if ($humanApproval -ne "approved") {
      Add-Result "fail" $RelativePath "Passed phase gate must have human_approval set to approved."
    }

    if ((Has-Property $Gate "markdown_json_alignment_checked") -and (-not [bool]$Gate.markdown_json_alignment_checked)) {
      Add-Result "fail" $RelativePath "Passed phase gate must have markdown_json_alignment_checked set to true."
    }

    if ((Has-Property $Gate "errors_fixed") -and (Has-Property $Gate.errors_fixed "no_unresolved_current_phase_errors_remain") -and (-not [bool]$Gate.errors_fixed.no_unresolved_current_phase_errors_remain)) {
      Add-Result "fail" $RelativePath "Passed phase gate must confirm no unresolved current-phase errors remain."
    }

    if ((Has-Property $Gate "security_privacy_check") -and (Has-Property $Gate.security_privacy_check "checked_or_not_relevant") -and (-not [bool]$Gate.security_privacy_check.checked_or_not_relevant)) {
      Add-Result "fail" $RelativePath "Passed phase gate must have security_privacy_check.checked_or_not_relevant set to true."
    }

    if ((Has-Property $Gate "human_actions") -and (Has-Property $Gate.human_actions "required_actions_complete_or_deferred") -and (-not [bool]$Gate.human_actions.required_actions_complete_or_deferred)) {
      Add-Result "fail" $RelativePath "Passed phase gate must confirm required human actions are complete or deferred."
    }

    if ((Has-Property $Gate "open_questions") -and (Has-Property $Gate.open_questions "no_blocking_questions_remain") -and (-not [bool]$Gate.open_questions.no_blocking_questions_remain)) {
      Add-Result "fail" $RelativePath "Passed phase gate must confirm no blocking questions remain."
    }
  }

  if ($gateStatus -eq "deferred-with-approval") {
    if ($humanApproval -ne "approved") {
      Add-Result "fail" $RelativePath "Deferred-with-approval phase gate must have human_approval set to approved."
    }

    if ((-not (Has-Property $Gate "deferred_issues")) -or @($Gate.deferred_issues).Count -eq 0) {
      Add-Result "fail" $RelativePath "Deferred-with-approval phase gate must list deferred_issues."
    }
  }
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

  if ($leaf -eq "Explanation.md") {
    return $null
  }

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

  Validate-JsonSchema $RelativePath $json

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

      Validate-PhaseGateSemantics $RelativePath $json

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

    if (Has-Property $json "current_phase_gate") {
      $supportedGateStatuses = @("pending", "passed", "blocked", "deferred-with-approval")
      if ($supportedGateStatuses -notcontains ([string]$json.current_phase_gate).ToLowerInvariant()) {
        Add-Result "warning" $RelativePath "Project status uses unsupported current_phase_gate '$($json.current_phase_gate)'."
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

  if (Has-Property $status "checklist_files") {
    if (Has-Property $status.checklist_files "human") {
      $humanChecklistPath = (($Directory + "/" + $status.checklist_files.human) -replace "\\", "/")
      if ($null -eq (Read-RepoText $humanChecklistPath)) {
        Add-Result "fail" $statusPath "status.json checklist_files.human points to missing file '$($status.checklist_files.human)'."
      }
    }

    if (Has-Property $status.checklist_files "machine") {
      $machineChecklistPath = (($Directory + "/" + $status.checklist_files.machine) -replace "\\", "/")
      if ($null -eq (Read-RepoText $machineChecklistPath)) {
        Add-Result "fail" $statusPath "status.json checklist_files.machine points to missing file '$($status.checklist_files.machine)'."
      }
    }
  }

  foreach ($field in @("project_name", "slug")) {
    if ((Has-Property $status $field) -and (Has-Property $checklist $field)) {
      if ([string]$status.($field) -ne [string]$checklist.($field)) {
        Add-Result "fail" $statusPath "status.json $field '$($status.($field))' differs from project-checklist.json $field '$($checklist.($field))'."
      }
    }
  }

  if ((Has-Property $status "current_phase") -and (Has-Property $checklist "current_phase")) {
    if ([string]$status.current_phase -ne [string]$checklist.current_phase) {
      Add-Result "warning" $statusPath "status.json current_phase '$($status.current_phase)' differs from project-checklist.json current_phase '$($checklist.current_phase)'."
    }
  }

  if (Has-Property $status "current_phase") {
    $currentPhaseRecord = Find-ChecklistPhase $checklist ([string]$status.current_phase)
    if ($null -eq $currentPhaseRecord) {
      Add-Result "fail" $checklistPath "project-checklist.json does not include current_phase '$($status.current_phase)' in phases by id or name."
    } elseif (Has-Property $status "current_phase_gate") {
      $currentGateStatus = ([string]$status.current_phase_gate).ToLowerInvariant()
      if (($currentGateStatus -eq "passed") -and (Has-Property $currentPhaseRecord "status") -and ([string]$currentPhaseRecord.status -ne "approved")) {
        Add-Result "warning" $checklistPath "Current phase gate is passed but checklist phase '$($currentPhaseRecord.id)' status is '$($currentPhaseRecord.status)' instead of approved."
      }
    }
  }

  if ((Has-Property $status "open_questions") -and (Has-Property $checklist "open_questions")) {
    $statusQuestions = Get-NormalizedStringArray $status "open_questions"
    $checklistQuestions = Get-NormalizedStringArray $checklist "open_questions"
    if (-not (Test-StringArraysEqual $statusQuestions $checklistQuestions)) {
      Add-Result "warning" $statusPath "status.json open_questions differ from project-checklist.json open_questions."
    }
  }

  if (Has-Property $checklist "phases") {
    $activeStatuses = @("in-progress", "blocked", "ready-for-gate")
    foreach ($phase in @($checklist.phases)) {
      if ((Has-Property $phase "status") -and ($activeStatuses -contains [string]$phase.status)) {
        if ((Has-Property $status "current_phase") -and (-not (Test-PhaseMatchesCurrent $phase ([string]$status.current_phase)))) {
          Add-Result "warning" $checklistPath "Phase '$($phase.id)' is '$($phase.status)' but status.json current_phase is '$($status.current_phase)'."
        }
      }
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
  foreach ($root in @("contracts/schemas", "templates", "projects")) {
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
