$ErrorActionPreference = 'Stop'

$eclipseProcesses = Get-Process -Name "eclipse" -ErrorAction SilentlyContinue

if ($eclipseProcesses) {
    Stop-Process -Name "eclipse" -Force
}