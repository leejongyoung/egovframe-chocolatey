$ErrorActionPreference = 'Stop'
$packageName = 'egovframe'
$programFilesDir = "${env:ProgramFiles}\eGovFrame"
$desktopPath = [Environment]::GetFolderPath('Desktop')
$shortcutPath = Join-Path $desktopPath "eclipse.lnk"

Remove-Item -Recurse -Force -Path $programFilesDir -ErrorAction SilentlyContinue

Remove-Item -Path $shortcutPath -Force -ErrorAction SilentlyContinue

[array]$key = Get-UninstallRegistryKey -SoftwareName "$packageName*"

if ($key.Count -eq 1) {
    $key | % {
        $installerType = 'MSI_OR_EXE'
        $silentArgs = '/qn /norestart'
        $validExitCodes = @(0, 3010, 1605, 1614, 1641)
        $file = $_.UninstallString
        
        Uninstall-ChocolateyPackage -PackageName $packageName `
                                    -FileType $installerType `
                                    -SilentArgs $silentArgs `
                                    -ValidExitCodes $validExitCodes `
                                    -File $file
    }
}