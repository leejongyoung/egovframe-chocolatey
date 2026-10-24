$ErrorActionPreference = 'Stop'

$installRoot  = Join-Path (Get-ToolsLocation) 'eGovFrame'
$workspaceDir = Join-Path $installRoot 'workspace-egov'

foreach ($name in 'eclipse', 'notice', '.staging') {
    $path = Join-Path $installRoot $name
    if (Test-Path $path) {
        Remove-Item -Recurse -Force -Path $path
    }
}

$desktopPath = [Environment]::GetFolderPath('Desktop')
if ($desktopPath) {
    Remove-Item -Path (Join-Path $desktopPath 'eGovFrame.lnk') -Force -ErrorAction SilentlyContinue
}

# workspace-egov holds user projects: never delete it automatically.
if (Test-Path $workspaceDir) {
    Write-Warning "Your workspace was kept: $workspaceDir. Delete it manually if you no longer need it."
}
elseif (Test-Path $installRoot) {
    Remove-Item -Recurse -Force -Path $installRoot
}
