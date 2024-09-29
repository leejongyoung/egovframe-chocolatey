$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName = 'egovframe'
$url64      = 'https://maven.egovframe.go.kr/publist/HDD1/public/eGovFrameDev-4.2.0-64bit.zip'

$packageArgs = @{
    packageName   = $env:ChocolateyPackageName
    unzipLocation = $toolsDir
    fileType      = 'zip'
    url64bit      = $url64
    softwareName  = 'egovframe*'
    validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyZipPackage @packageArgs

$programFilesDir = "${env:ProgramFiles}\eGovFrame"

if (Test-Path "$programFilesDir") {
    Write-Host "Program Files에 eGovFrame 폴더가 이미 존재합니다. 기존 폴더를 제거하고 다시 복사합니다."
    Remove-Item -Recurse -Force "$programFilesDir"
}

Write-Host "eclipse 폴더를 Program Files로 복사합니다."
Move-Item -Path "$toolsDir\eclipse" -Destination "$programFilesDir" -Force

$desktopPath = [Environment]::GetFolderPath('Desktop')
$shortcutPath = Join-Path $desktopPath "eclipse.lnk"
$targetPath = Join-Path "$programFilesDir" "eclipse.exe"

if (Test-Path $shortcutPath) {
    Write-Host "기존 Eclipse 바로가기가 바탕화면에 존재합니다. 기존 바로가기를 제거합니다."
    Remove-Item -Force $shortcutPath
}

if (Test-Path $targetPath) {
    $WScriptShell = New-Object -ComObject WScript.Shell
    $shortcut = $WScriptShell.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = $targetPath
    $shortcut.WorkingDirectory = "$programFilesDir"
    $shortcut.IconLocation = "$targetPath"
    $shortcut.Save()

    Write-Host "Eclipse 바로가기가 바탕화면에 생성되었습니다."
} else {
    Write-Host "Eclipse 실행 파일을 찾을 수 없습니다. 경로를 확인하세요: $targetPath"
}