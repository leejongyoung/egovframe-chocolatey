$ErrorActionPreference = 'Stop'

$version      = '5.0.2'
$url64        = "https://maven.egovframe.go.kr/publist/HDD1/public/egovframework_v5.0/2_DevelopmentEnvironment/eGovFrame-Dev/$version/eGovFrameDev-$version-Windows-64bit.zip"
$checksum64   = '55EDE08F05ED12A345B5DD6CC70E8B3A1BA4C8C7ABAB49FB2563032B8F65F8ED'

# Eclipse and the workspace must be writable by the user (plug-in updates, projects),
# so install under the Chocolatey tools location instead of Program Files.
$installRoot  = Join-Path (Get-ToolsLocation) 'eGovFrame'
$eclipseDir   = Join-Path $installRoot 'eclipse'
$workspaceDir = Join-Path $installRoot 'workspace-egov'

# The archive is extracted into a staging folder on the same volume as the final
# location, so the final placement below is a rename instead of a copy of ~17,000 files.
$stagingDir   = Join-Path $installRoot '.staging'

if (Test-Path $stagingDir) {
    Remove-Item -Recurse -Force $stagingDir
}
New-Item -ItemType Directory -Force -Path $installRoot | Out-Null

# Download and verify the checksum with the standard helper, then extract with
# -DisableLogging. By default the helper runs 7z with -bb1 and replays the name of every
# extracted file (~17,000) through the Chocolatey logger, which is slow on a debug-logging
# host such as the package verifier (about 10 ms per line).
$zipDir  = Join-Path $env:TEMP "chocolatey\$($env:ChocolateyPackageName)\$($env:ChocolateyPackageVersion)"
$zipPath = Join-Path $zipDir "eGovFrameDev-$version-Windows-64bit.zip"
New-Item -ItemType Directory -Force -Path $zipDir | Out-Null

$downloadArgs = @{
    PackageName    = $env:ChocolateyPackageName
    FileFullPath   = $zipPath
    Url64bit       = $url64
    Checksum64     = $checksum64
    ChecksumType64 = 'sha256'
}

$unzipArgs = @{
    PackageName  = $env:ChocolateyPackageName
    FileFullPath = $zipPath
    Destination  = $stagingDir
}

try {
    Get-ChocolateyWebFile @downloadArgs | Out-Null
    Get-ChocolateyUnzip @unzipArgs -DisableLogging | Out-Null
}
finally {
    Remove-Item -Recurse -Force $zipDir -ErrorAction SilentlyContinue
}

foreach ($name in 'eclipse', 'notice') {
    $source = Join-Path $stagingDir $name
    if (-not (Test-Path $source)) {
        throw "Expected '$name' folder not found in the downloaded archive. The archive layout may have changed."
    }

    $target = Join-Path $installRoot $name
    if (Test-Path $target) {
        Remove-Item -Recurse -Force $target
    }
    Move-Item -Path $source -Destination $target
}

# workspace-egov holds user projects: keep an existing one untouched.
if (Test-Path $workspaceDir) {
    Write-Host "Keeping existing workspace: $workspaceDir"
}
else {
    $source = Join-Path $stagingDir 'workspace-egov'
    if (-not (Test-Path $source)) {
        throw "Expected 'workspace-egov' folder not found in the downloaded archive. The archive layout may have changed."
    }
    Move-Item -Path $source -Destination $workspaceDir
}

Remove-Item -Recurse -Force $stagingDir

# The vendor archive pre-selects a workspace path of its own build machine
# (C:\eGovFrameDev-<version>-Windows-64bit\workspace-egov). Point it at the installed workspace.
$idePrefs = Join-Path $eclipseDir 'configuration\.settings\org.eclipse.ui.ide.prefs'
if (Test-Path $idePrefs) {
    $escapedWorkspace = ($workspaceDir -replace '\\', '\\') -replace ':', '\:'
    $content = [System.IO.File]::ReadAllText($idePrefs)
    $updated = [regex]::Replace(
        $content,
        '(?m)^RECENT_WORKSPACES=[^\r\n]*',
        { param($m) "RECENT_WORKSPACES=$escapedWorkspace" })
    [System.IO.File]::WriteAllText($idePrefs, $updated, (New-Object System.Text.UTF8Encoding($false)))
}

$desktopPath = [Environment]::GetFolderPath('Desktop')
$targetPath  = Join-Path $eclipseDir 'eclipse.exe'

if ($desktopPath -and (Test-Path $targetPath)) {
    $shortcutPath = Join-Path $desktopPath 'eGovFrame.lnk'
    Install-ChocolateyShortcut -ShortcutFilePath $shortcutPath -TargetPath $targetPath -WorkingDirectory $eclipseDir -IconLocation $targetPath
}
else {
    Write-Warning 'Desktop shortcut was not created (no Desktop folder for this account). Run eclipse.exe from the install folder instead.'
}

Write-Host "eGovFrame $version installed to $installRoot"
