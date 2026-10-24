$ErrorActionPreference = 'Stop'

$installRoot = Join-Path (Get-ToolsLocation) 'eGovFrame'

# Stop only the Eclipse started from this package, not other Eclipse installations.
$eclipseProcesses = Get-Process -Name 'eclipse' -ErrorAction SilentlyContinue | Where-Object {
    try { $_.Path -and $_.Path.StartsWith($installRoot, [System.StringComparison]::OrdinalIgnoreCase) } catch { $false }
}

if ($eclipseProcesses) {
    $eclipseProcesses | Stop-Process -Force
}
