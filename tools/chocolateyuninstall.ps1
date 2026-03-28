$ErrorActionPreference = 'Stop'
$packageName = 'egovframe'
$programFilesDir = "${env:ProgramFiles}\eGovFrame"
$desktopPath = [Environment]::GetFolderPath('Desktop')
$shortcutPath = Join-Path $desktopPath "eclipse.lnk"

Remove-Item -Recurse -Force -Path $programFilesDir -ErrorAction SilentlyContinue

Remove-Item -Path $shortcutPath -Force -ErrorAction SilentlyContinue