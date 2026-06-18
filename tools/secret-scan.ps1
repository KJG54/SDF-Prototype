param(
  [switch]$Staged,
  [switch]$All
)

$ErrorActionPreference = "Stop"

$patterns = @(
  @{ Name = "GitHub fine-grained token"; Regex = "github_pat_[A-Za-z0-9_]{20,}" },
  @{ Name = "GitHub classic token"; Regex = "gh[pousr]_[A-Za-z0-9_]{20,}" },
  @{ Name = "OpenAI-style API key"; Regex = "sk-[A-Za-z0-9_-]{20,}" },
  @{ Name = "GitHub token assignment"; Regex = "(?i)\b(GITHUB_TOKEN|GH_TOKEN)\s*=\s*[A-Za-z0-9_][^\s#]*" },
  @{ Name = "Generic secret assignment"; Regex = "(?i)\b(API_KEY|SECRET|PASSWORD|TOKEN)\s*=\s*[A-Za-z0-9_][^\s#]*" }
)

$allowedFiles = @(
  ".env.example"
)

function Get-StagedFiles {
  git diff --cached --name-only --diff-filter=ACMR
}

function Get-TrackedFiles {
  git ls-files
}

if ($All) {
  $files = @(Get-TrackedFiles)
} else {
  $files = @(Get-StagedFiles)
}

if ($files.Count -eq 0) {
  Write-Output "Secret scan: no files to scan."
  exit 0
}

$findings = @()

foreach ($file in $files) {
  if ([string]::IsNullOrWhiteSpace($file)) {
    continue
  }

  $normalized = $file -replace "\\", "/"
  if ($allowedFiles -contains $normalized) {
    continue
  }

  try {
    if ($All) {
      if (-not (Test-Path -LiteralPath $file)) {
        continue
      }
      $content = Get-Content -Raw -LiteralPath $file
    } else {
      $content = git show ":$file" 2>$null
    }
  } catch {
    continue
  }

  if ($null -eq $content) {
    continue
  }

  $lines = $content -split "`r?`n"
  for ($i = 0; $i -lt $lines.Count; $i++) {
    foreach ($pattern in $patterns) {
      if ($lines[$i] -match $pattern.Regex) {
        $findings += [pscustomobject]@{
          File = $file
          Line = $i + 1
          Pattern = $pattern.Name
        }
      }
    }
  }
}

if ($findings.Count -gt 0) {
  Write-Output "Secret scan failed. Potential secrets found:"
  $findings | Sort-Object File, Line, Pattern | Format-Table -AutoSize
  Write-Output "Review these files manually. Do not paste secret values into chat or artifacts."
  exit 1
}

Write-Output "Secret scan passed."
