$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName = 'egovframe'
$url64 = 'https://maven.egovframe.go.kr/publist/HDD1/public/eGovFrameDev-4.2.0-64bit.zip'
$url64Checksum = '7a6d7948eb0228841f3c76581508ad530c99942c12c5e0cb0f44307d2a55d10b'

$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    unzipLocation  = $toolsDir
    fileType       = 'zip'
    url64bit       = $url64
    checksum64     = $url64Checksum
    checksumType64 = 'sha256'
    softwareName   = 'egovframe*'
    validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyZipPackage @packageArgs

$programFilesDir = "${env:ProgramFiles}\eGovFrame"

if (Test-Path "$programFilesDir") {
    Remove-Item -Recurse -Force "$programFilesDir"
}

Move-Item -Path "$toolsDir\eclipse" -Destination "$programFilesDir" -Force

$desktopPath = [Environment]::GetFolderPath('Desktop')
$shortcutPath = Join-Path $desktopPath "eclipse.lnk"
$targetPath = Join-Path "$programFilesDir" "eclipse.exe"

Remove-Item -Path $shortcutPath -Force -ErrorAction SilentlyContinue

if (Test-Path $targetPath) {
    Install-ChocolateyShortcut -ShortcutFilePath "$shortcutPath" -TargetPath "$targetPath" -WorkingDirectory "$programFilesDir" -IconLocation "$targetPath"
}