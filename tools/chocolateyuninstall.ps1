$ErrorActionPreference = 'Stop'
$packageName = 'egovframe'
$programFilesDir = "${env:ProgramFiles}\eGovFrame"
$desktopPath = [Environment]::GetFolderPath('Desktop')
$shortcutPath = Join-Path $desktopPath "eclipse.lnk"

if (Test-Path $programFilesDir) {
    Write-Host "eGovFrame 폴더를 삭제합니다: $programFilesDir"
    Remove-Item -Recurse -Force -Path $programFilesDir
} else {
    Write-Warning "$programFilesDir 경로가 존재하지 않습니다. 이미 제거되었을 수 있습니다."
}

if (Test-Path $shortcutPath) {
    Write-Host "바탕화면의 Eclipse 바로가기를 삭제합니다."
    Remove-Item -Force -Path $shortcutPath
} else {
    Write-Warning "바탕화면에 Eclipse 바로가기가 존재하지 않습니다."
}

[array]$key = Get-UninstallRegistryKey -SoftwareName "$packageName*"

if ($key.Count -eq 1) {
    $key | % {
        $packageArgs = @ {
            packageName   = $packageName
            softwareName  = $_.DisplayName
            fileType      = 'MSI_OR_EXE'
            silentArgs    = '/qn /norestart'
            validExitCodes = @(0, 3010, 1605, 1614, 1641)
        }

        if ($_.UninstallString -match 'msiexec') {
            $packageArgs['silentArgs'] = "$($_.PSChildName) $($packageArgs['silentArgs'])"
            $packageArgs['file'] = ''
        } else {
            $packageArgs['file'] = "$($_.UninstallString)"
        }

        Uninstall-ChocolateyPackage @packageArgs
    }
} elseif ($key.Count -eq 0) {
    Write-Warning "$packageName는 이미 제거되었습니다."
} elseif ($key.Count -gt 1) {
    Write-Warning "$($key.Count)개의 일치 항목이 발견되었습니다!"
    Write-Warning "충돌을 방지하기 위해 프로그램을 제거하지 않습니다."
    Write-Warning "다음 항목이 일치했습니다:"
    $key | % { Write-Warning "- $($_.DisplayName)" }
}