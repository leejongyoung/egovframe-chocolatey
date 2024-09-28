$ErrorActionPreference = 'Stop'

$eclipseProcesses = Get-Process -Name "eclipse" -ErrorAction SilentlyContinue

if ($eclipseProcesses) {
    Write-Host "Eclipse 프로세스가 실행 중입니다. 종료합니다."
    Stop-Process -Name "eclipse" -Force
} else {
    Write-Host "Eclipse 프로세스가 실행 중이지 않습니다."
}