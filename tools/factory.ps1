param(
  [Parameter(Position = 0)]
  [ValidateSet("help", "doctor", "status", "validate", "secret-scan", "toolbox", "event", "events", "tasks")]
  [string]$Command = "help",

  [string]$Project = "",
  [string]$EventType = "",
  [string]$Summary = "",
  [string]$Details = "",
  [string[]]$RelatedFile = @(),
  [int]$Count = 20,
  [switch]$WarningsAsFailures
)

$ErrorActionPreference = "Stop"

$scriptPath = $MyInvocation.MyCommand.Path
$toolsDir = Split-Path -Parent $scriptPath
$repoRoot = Split-Path -Parent $toolsDir

Push-Location $repoRoot

function Write-Section {
  param([string]$Title)

  Write-Output ""
  Write-Output $Title
  Write-Output ("-" * $Title.Length)
}

function Read-JsonFile {
  param([string]$Path)

  if (-not (Test-Path -LiteralPath $Path)) {
    throw "Missing file: $Path"
  }

  return Get-Content -Raw -LiteralPath $Path | ConvertFrom-Json
}

function Invoke-RepoScript {
  param(
    [string]$Path,
    [string[]]$Arguments
  )

  $fullPath = Join-Path $repoRoot $Path
  if (-not (Test-Path -LiteralPath $fullPath)) {
    throw "Missing script: $Path"
  }

  & powershell.exe -NoProfile -ExecutionPolicy Bypass -File $fullPath @Arguments
  if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
  }
}

function Show-Help {
  Write-Output "Software Factory local command runner"
  Write-Output ""
  Write-Output "Usage:"
  Write-Output "  powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\factory.ps1 <command>"
  Write-Output ""
  Write-Output "Commands:"
  Write-Output "  help                         Show this help."
  Write-Output "  doctor                       Check local framework files and tool availability."
  Write-Output "  status [-Project <slug>]     Show active or named project status."
  Write-Output "  validate [-WarningsAsFailures] Run artifact validation across templates and projects."
  Write-Output "  secret-scan                  Run the tracked-file secret scan."
  Write-Output "  toolbox                      Show tool registry entries grouped by status."
  Write-Output "  event -EventType <type> -Summary <text> [-Project <slug>] Append a local JSONL event."
  Write-Output "  events [-Project <slug>] [-Count <n>] Show recent local events."
  Write-Output "  tasks [-Project <slug>]       Show file-based task records."
  Write-Output ""
  Write-Output "This runner is repo-local and optional. It does not install tools, create projects, advance phases, approve gates, publish, push, or deploy."
}

function Show-Doctor {
  $checks = @()

  foreach ($path in @(
    "factory.config.json",
    "tools/registry.json",
    "tools/artifact-validate.ps1",
    "tools/secret-scan.ps1",
    "standards/tool-adoption.md",
    "standards/starter-toolbox.md",
    "contracts/schemas/project-status.schema.json",
    "contracts/schemas/project-checklist.schema.json",
    "contracts/schemas/phase-gate.schema.json",
    "contracts/schemas/phase-summary.schema.json",
    "contracts/schemas/artifact-base.schema.json",
    "contracts/schemas/approval.schema.json",
    "contracts/schemas/architecture.schema.json",
    "contracts/schemas/build-plan.schema.json",
    "contracts/schemas/environment-setup.schema.json",
    "contracts/schemas/human-action.schema.json",
    "contracts/schemas/implementation-notes.schema.json",
    "contracts/schemas/local-event.schema.json",
    "contracts/schemas/project-operating-model.schema.json",
    "contracts/schemas/project-memory-packet.schema.json",
    "contracts/schemas/requirements.schema.json",
    "contracts/schemas/review-report.schema.json",
    "contracts/schemas/scaffold-notes.schema.json",
    "contracts/schemas/shipping-plan.schema.json",
    "contracts/schemas/task-record.schema.json",
    "contracts/schemas/verification-report.schema.json",
    "standards/file-based-task-records.md",
    "standards/local-logs-events.md",
    "standards/project-operating-tiers.md"
  )) {
    $checks += [pscustomobject]@{
      Check = $path
      Status = if (Test-Path -LiteralPath $path) { "ok" } else { "missing" }
    }
  }

  foreach ($path in @("factory.config.json", "tools/registry.json")) {
    try {
      Read-JsonFile $path | Out-Null
      $status = "ok"
    } catch {
      $status = "invalid JSON"
    }

    $checks += [pscustomobject]@{
      Check = "$path parses"
      Status = $status
    }
  }

  $schemaFiles = Get-ChildItem -LiteralPath "contracts/schemas" -Filter "*.json" -File -ErrorAction SilentlyContinue
  foreach ($schema in @($schemaFiles)) {
    try {
      Read-JsonFile $schema.FullName | Out-Null
      $status = "ok"
    } catch {
      $status = "invalid JSON"
    }

    $checks += [pscustomobject]@{
      Check = "schema: $($schema.Name)"
      Status = $status
    }
  }

  $git = Get-Command git -ErrorAction SilentlyContinue
  $checks += [pscustomobject]@{
    Check = "git available"
    Status = if ($null -ne $git) { "ok" } else { "missing" }
  }

  Write-Section "Doctor"
  $checks | Format-Table -AutoSize

  $missing = @($checks | Where-Object { $_.Status -ne "ok" })
  if ($missing.Count -gt 0) {
    Write-Output "Doctor found issues. Fix missing or invalid files before relying on the runner."
    exit 1
  }

  Write-Output "Doctor passed."
}

function Show-Status {
  $config = Read-JsonFile "factory.config.json"
  $slug = $Project

  if ([string]::IsNullOrWhiteSpace($slug) -and $config.PSObject.Properties["active_project"]) {
    $slug = [string]$config.active_project
  }

  if ([string]::IsNullOrWhiteSpace($slug)) {
    Write-Section "Projects"
    $projectDirs = Get-ChildItem -LiteralPath "projects" -Directory -ErrorAction SilentlyContinue
    $rows = @()

    foreach ($projectDir in @($projectDirs)) {
      $statusPath = Join-Path $projectDir.FullName "status.json"
      if (Test-Path -LiteralPath $statusPath) {
        $status = Read-JsonFile $statusPath
        $rows += [pscustomobject]@{
          Slug = $projectDir.Name
          State = $status.state
          Phase = $status.current_phase
          Gate = $status.current_phase_gate
          NextStep = $status.next_step
        }
      }
    }

    if ($rows.Count -eq 0) {
      Write-Output "No projects with status.json were found."
    } else {
      $rows | Format-Table -AutoSize -Wrap
      Write-Output ""
      Write-Output "No active_project is set in factory.config.json. Use -Project <slug> to inspect one project."
    }

    return
  }

  $projectRoot = Join-Path "projects" $slug
  $statusPath = Join-Path $projectRoot "status.json"
  $status = Read-JsonFile $statusPath

  Write-Section "Project Status"
  [pscustomobject]@{
    Project = $status.project_name
    Slug = $status.slug
    State = $status.state
    Phase = $status.current_phase
    Gate = $status.current_phase_gate
  } | Format-List

  Write-Section "Summary"
  Write-Output $status.summary

  Write-Section "Latest Decision"
  Write-Output $status.latest_decision

  Write-Section "Next Step"
  Write-Output $status.next_step

  Write-Section "Open Questions"
  if ($status.open_questions.Count -eq 0) {
    Write-Output "None."
  } else {
    $status.open_questions | ForEach-Object { Write-Output "- $_" }
  }

  Write-Section "Blocking Issues"
  if ($status.blocking_issues.Count -eq 0) {
    Write-Output "None."
  } else {
    $status.blocking_issues | ForEach-Object { Write-Output "- $_" }
  }
}

function Invoke-Validation {
  $arguments = @("-All")
  if ($WarningsAsFailures) {
    $arguments += "-WarningsAsFailures"
  }

  Invoke-RepoScript "tools/artifact-validate.ps1" $arguments
}

function Invoke-SecretScan {
  Invoke-RepoScript "tools/secret-scan.ps1" @("-All")
}

function Show-Toolbox {
  $registry = Read-JsonFile "tools/registry.json"
  $tools = @($registry.tools)

  if ($tools.Count -eq 0) {
    Write-Output "No tools are registered in tools/registry.json."
    return
  }

  foreach ($status in @("core", "preferred", "optional", "deferred", "restricted", "rejected-for-now", "known", "approved", "deprecated")) {
    $group = @($tools | Where-Object { $_.status -eq $status } | Sort-Object name)
    if ($group.Count -eq 0) {
      continue
    }

    Write-Section $status
    $group |
      Select-Object @{ Name = "Tool"; Expression = { $_.name } }, @{ Name = "Responsibility"; Expression = { $_.responsibility } } |
      Format-Table -AutoSize -Wrap
  }
}

function Get-EventLogPath {
  param([string]$Slug)

  $month = (Get-Date).ToUniversalTime().ToString("yyyy-MM")

  if ([string]::IsNullOrWhiteSpace($Slug)) {
    return (Join-Path "logs/events" "$month.jsonl")
  }

  return (Join-Path (Join-Path "projects" $Slug) (Join-Path "logs/events" "$month.jsonl"))
}

function Write-LocalEvent {
  if ([string]::IsNullOrWhiteSpace($EventType)) {
    throw "EventType is required for the event command."
  }

  if ([string]::IsNullOrWhiteSpace($Summary)) {
    throw "Summary is required for the event command."
  }

  $scope = if ([string]::IsNullOrWhiteSpace($Project)) { "framework" } else { "project" }
  $timestamp = (Get-Date).ToUniversalTime()
  $event = [ordered]@{
    event_id = "evt-$($timestamp.ToString("yyyyMMddHHmmssfff"))-$([guid]::NewGuid().ToString("N").Substring(0, 8))"
    timestamp_utc = $timestamp.ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
    scope = $scope
    project_slug = if ($scope -eq "project") { $Project } else { $null }
    actor = "local-runner"
    event_type = $EventType
    summary = $Summary
    details = $Details
    source = "tools/factory.ps1"
    related_files = @($RelatedFile)
  }

  $path = Get-EventLogPath $Project
  $directory = Split-Path $path -Parent
  if (-not (Test-Path -LiteralPath $directory)) {
    New-Item -ItemType Directory -Path $directory | Out-Null
  }

  $event | ConvertTo-Json -Depth 5 -Compress | Add-Content -LiteralPath $path -Encoding UTF8
  Write-Output "Recorded event: $($event.event_id)"
  Write-Output "Path: $path"
}

function Show-Events {
  $path = Get-EventLogPath $Project

  Write-Section "Events"
  if (-not (Test-Path -LiteralPath $path)) {
    Write-Output "No event log found at $path."
    return
  }

  $lines = @(Get-Content -LiteralPath $path | Where-Object { -not [string]::IsNullOrWhiteSpace($_) } | Select-Object -Last $Count)
  if ($lines.Count -eq 0) {
    Write-Output "No events recorded."
    return
  }

  $events = @()
  foreach ($line in $lines) {
    try {
      $events += ($line | ConvertFrom-Json)
    } catch {
      $events += [pscustomobject]@{
        timestamp_utc = ""
        scope = ""
        event_type = "invalid-json-line"
        summary = $line
        source = $path
      }
    }
  }

  $events |
    Select-Object timestamp_utc, scope, project_slug, event_type, summary, source |
    Format-Table -AutoSize -Wrap
}

function Get-TaskFiles {
  param([string]$Slug)

  $roots = @()
  if ([string]::IsNullOrWhiteSpace($Slug)) {
    if (Test-Path -LiteralPath "artifacts/tasks") {
      $roots += "artifacts/tasks"
    }
    if (Test-Path -LiteralPath "projects") {
      Get-ChildItem -LiteralPath "projects" -Directory -ErrorAction SilentlyContinue |
        ForEach-Object {
          $candidate = Join-Path $_.FullName "artifacts/tasks"
          if (Test-Path -LiteralPath $candidate) {
            $roots += $candidate
          }
        }
    }
  } else {
    $candidate = Join-Path (Join-Path "projects" $Slug) "artifacts/tasks"
    if (Test-Path -LiteralPath $candidate) {
      $roots += $candidate
    }
  }

  $files = @()
  foreach ($root in $roots) {
    $files += @(Get-ChildItem -LiteralPath $root -Filter "TASK-*.json" -File -ErrorAction SilentlyContinue)
  }

  return $files
}

function Show-Tasks {
  $files = @(Get-TaskFiles $Project)

  Write-Section "Tasks"
  if ($files.Count -eq 0) {
    if ([string]::IsNullOrWhiteSpace($Project)) {
      Write-Output "No task records found."
    } else {
      Write-Output "No task records found for project '$Project'."
    }
    return
  }

  $rows = @()
  foreach ($file in $files) {
    $relativeFile = (($file.FullName.Substring($repoRoot.Length).TrimStart("\", "/")) -replace "\\", "/")
    try {
      $task = Read-JsonFile $file.FullName
      $rows += [pscustomobject]@{
        Id = $task.id
        Status = $task.status
        Scope = $task.scope
        Project = $task.project_slug
        Phase = $task.phase
        AssignedTo = $task.assigned_to
        Claim = $task.claim_status
        Title = $task.title
        File = $relativeFile
      }
    } catch {
      $rows += [pscustomobject]@{
        Id = "invalid"
        Status = "invalid-json"
        Scope = ""
        Project = ""
        Phase = ""
        AssignedTo = ""
        Claim = ""
        Title = $_.Exception.Message
        File = $relativeFile
      }
    }
  }

  $rows | Sort-Object Project, Id | Format-Table -AutoSize -Wrap
}

try {
  switch ($Command) {
    "help" { Show-Help }
    "doctor" { Show-Doctor }
    "status" { Show-Status }
    "validate" { Invoke-Validation }
    "secret-scan" { Invoke-SecretScan }
    "toolbox" { Show-Toolbox }
    "event" { Write-LocalEvent }
    "events" { Show-Events }
    "tasks" { Show-Tasks }
  }
} finally {
  Pop-Location
}
