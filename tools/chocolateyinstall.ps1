$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName = 'egovframe'
$url64 = 'https://maven.egovframe.go.kr/publist/HDD1/public/eGovFrameDev-4.3.1-64bit.zip'
$url64Checksum = 'DC74BC1F729222089B1272CA920B276C392CEC344358537A3A57636C3D5B24E0'

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