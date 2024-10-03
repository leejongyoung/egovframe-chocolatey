# eGovFrame Chocolatey 패키지

## 소개
eGovFrame Chocolatey 패키지에 오신 것을 환영합니다. Chocolatey는 윈도우에서 소프트웨어를 명령줄을 통해 쉽게 설치할 수 있도록 도와주는 패키지 관리자입니다. 이 패키지는 한국 정부에서 개발한 오픈소스 프레임워크인 eGovFrame을 쉽게 설치할 수 있는 방법을 제공합니다. eGovFrame은 공공 부문 애플리케이션 개발을 위해 설계되었으며, 한국에서 IT 프로젝트를 위한 표준화된 플랫폼으로 널리 사용되고 있습니다.

Chocolatey는 윈도우에서 소프트웨어 설치를 자동화하는 강력한 도구로, macOS의 Homebrew나 Linux의 APT와 유사한 역할을 합니다. Chocolatey는 소프트웨어의 종속성 관리, 업데이트 및 제거를 원활하게 처리합니다.

- [eGovFrame 공식 패키지](https://community.chocolatey.org/packages/egovframe)

## eGovFrame에 대하여
- **이름**: eGovFrame (전자표준프레임워크)
- **설명**: eGovFrame은 한국 정부에서 제공하는 오픈소스 프레임워크로, 웹 기반 공공 서비스를 개발하기 위해 설계되었습니다. 정부 표준 개발 플랫폼으로서, 한국 공공 부문의 IT 프로젝트에서 중요한 역할을 하며 전 세계적으로 사용이 가능합니다.
- **홈페이지**: [eGovFrame 공식 홈페이지](https://www.egovframe.go.kr)

## 설치가이드

### Chocolatey 설치
윈도우에 Chocolatey가 설치되어 있지 않다면 다음 단계를 따라 설치할 수 있습니다:

1. PowerShell을 관리자 권한으로 실행합니다. (`Windows 키 + R키` 실행, `powershell` 입력 후 `Control 키 + Shift 키 + Enter 키` 실행)
2. 다음 명령어를 실행합니다:
``` shell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

자세한 설치 방법은 Chocolatey 설치 가이드를 참조하세요.

### eGovFrame Chocolatey 설치

Chocolatey 설치가 완료되면, PowerShell 또는 명령 프롬프트에서 다음 명령어를 실행하여 eGovFrame을 쉽게 설치할 수 있습니다:

``` shell
choco install egovframe
```

### 특정 버전 설치

특정 버전의 eGovFrame을 설치하려면 다음과 같이 버전 번호를 지정할 수 있습니다:

``` shell
choco install egovframe --version=4.2.0

# [공지] 공식 저장소에서 배포 승인을 기다리고 있습니다. 승인이 완료될 때까지 아래 명령어를 사용하세요:
choco install egovframe --version=4.2.0 --pre
```

버전을 지정하지 않으면 기본적으로 최신 버전이 설치됩니다.

### 로컬 빌드에서 eGovFrame 설치하기

eGovFrame Chocolatey 패키지에 변경 사항을 적용하고 이를 로컬에서 빌드 및 설치하려면, 다음 단계를 따르세요:

1.	먼저, nuspec 파일을 기반으로 .nupkg 패키지를 생성해야 합니다. 이를 위해 choco pack 명령어를 사용합니다. 다음 명령어를 패키지의 .nuspec 파일이 있는 디렉토리에서 실행하세요:

``` shell
choco pack
```

이 명령어는 현재 디렉토리의 .nuspec 파일을 기반으로 egovframe.4.2.0.nupkg와 같은 패키지를 생성합니다.

2.	패키지가 성공적으로 생성되면, 다음으로 해당 패키지를 로컬에서 설치할 수 있습니다. 생성된 .nupkg 파일이 있는 디렉토리에서 다음 명령어를 실행하세요:

``` shell
choco install egovframe --source "C:\path\to\your\nupkg\file"
```

여기서 "C:\path\to\your\nupkg\file" 부분을 실제 .nupkg 파일의 경로로 변경해야 합니다. 이 명령어는 Chocolatey가 온라인 소스가 아닌 로컬에서 패키지를 설치하도록 합니다.

3.	설치가 완료되면, 다음 명령어를 사용해 패키지가 정상적으로 설치되었는지 확인할 수 있습니다:

``` shell
choco list
```

이 명령어는 로컬에 설치된 모든 패키지를 표시하며, 여기에서 egovframe 패키지를 확인할 수 있습니다.

### 애플리케이션 설치 경로

기본적으로 eGovFrame은 C:\Program Files\eGovFrame 디렉토리에 설치됩니다.

## 설치 후 설정

1. Eclipse 바로가기: 설치 후에는 Eclipse (eGovFrame IDE) 바로가기가 바탕화면에 생성됩니다.
2. Java 설치 확인: eGovFrame은 Java 17 이상이 필요합니다. Java가 설치되어 있지 않은 경우, 설치 과정에서 OpenJDK 17이 자동으로 설치됩니다.

## 자동 패키지 업데이트

이 패키지는 자동 패키지로 구성되어 있어, eGovFrame의 새로운 버전이 출시될 때 자동으로 업데이트됩니다. 이를 통해 항상 최신 기능과 보안 업데이트를 사용할 수 있습니다.

자동 패키지에 대한 자세한 내용은 [Chocolatey 자동 패키지 문서](https://docs.chocolatey.org/en-us/create/automatic-packages)에서 확인할 수 있습니다.

## Shim 생성

Chocolatey는 패키지에 포함된 실행 파일이나 설치 중 다운로드된 실행 파일을 자동으로 Shim 처리합니다. Shim은 전체 경로를 지정하지 않고도 명령줄에서 실행 파일을 실행할 수 있도록 해줍니다.

예를 들어, eGovFrame에 포함된 eclipse.exe는 자동으로 Shim 처리되므로, 명령 프롬프트에서 eclipse 명령어만 입력해도 실행할 수 있습니다.

- GUI 애플리케이션의 경우: Chocolatey는 실행 파일 옆에 .gui 파일을 생성하여 GUI 애플리케이션으로 인식되도록 합니다.
- 콘솔 애플리케이션의 경우: Chocolatey는 콘솔 기반 애플리케이션을 위해 자동으로 Shim 처리를 합니다.

자세한 내용은 [Chocolatey Shim 생성 문서](https://docs.chocolatey.org/en-us/features/shim)에서 확인할 수 있습니다.

## 제거 가이드

eGovFrame을 제거하려면, PowerShell 또는 명령 프롬프트에서 다음 명령어를 실행하세요:

``` shell
choco uninstall egovframe
```

이 명령어는 eGovFrame을 시스템에서 제거하며, 모든 파일과 바로가기도 삭제됩니다.

## 라이선스

eGovFrame은 Apache 2.0 라이선스를 따릅니다. 자세한 내용은 [Apache 2.0 라이선스](/tools/LICENSE.txt)에서 확인하세요.

## 연락처

더 많은 정보나 도움이 필요하다면 [eGovFrame 공식 웹사이트](https://www.egovframe.go.kr)를 방문하세요.