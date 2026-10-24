# eGovFrame Chocolatey 패키지

[![전자정부표준프레임워크](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/unversioned/flat-ko.svg)](https://www.egovframe.go.kr/)
[![Chocolatey Package Test](https://github.com/leejongyoung/egovframe-chocolatey/actions/workflows/test.yml/badge.svg?branch=main)](https://github.com/leejongyoung/egovframe-chocolatey/actions/workflows/test.yml)
[![License: Apache-2.0](https://img.shields.io/badge/license-Apache--2.0-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0)

[![English](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/en/outline.svg)](README.md)
[![한국어](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ko/flat.svg)](README.ko.md)

## 소개
eGovFrame Chocolatey 패키지에 오신 것을 환영합니다. Chocolatey는 윈도우에서 소프트웨어를 명령줄을 통해 쉽게 설치할 수 있도록 도와주는 패키지 관리자입니다. 이 패키지는 한국 정부에서 개발한 오픈소스 프레임워크인 eGovFrame을 쉽게 설치할 수 있는 방법을 제공합니다. eGovFrame은 공공 부문 애플리케이션 개발을 위해 설계되었으며, 한국에서 IT 프로젝트를 위한 표준화된 플랫폼으로 널리 사용되고 있습니다.

- [eGovFrame 공식 패키지](https://community.chocolatey.org/packages/egovframe)

## eGovFrame에 대하여
- **이름**: eGovFrame (전자정부표준프레임워크)
- **버전**: 5.0.2 (Windows 64bit 개발환경, Eclipse 2025-03, Java 21)
- **설명**: eGovFrame은 한국 정부에서 제공하는 오픈소스 프레임워크로, 웹 기반 공공 서비스를 개발하기 위해 설계되었습니다. Java와 Spring 프레임워크를 기반으로 구축되었습니다.
- **홈페이지**: [eGovFrame 공식 홈페이지](https://www.egovframe.go.kr)

## 설치 가이드

### eGovFrame 설치 (Chocolatey 활용)

Chocolatey가 설치되어 있다면, PowerShell 또는 명령 프롬프트에서 다음 명령어를 실행하여 eGovFrame을 쉽게 설치할 수 있습니다:

```shell
choco install egovframe
```

특정 버전을 설치하려면 다음과 같이 입력합니다:
```shell
choco install egovframe --version=5.0.2
```

### 애플리케이션 설치 경로
기본적으로 eGovFrame은 Chocolatey 도구 경로인 `C:\tools\eGovFrame`(`$env:ChocolateyToolsLocation\eGovFrame`)에 설치됩니다. Program Files가 아닌 이 경로를 쓰는 이유는 관리자 권한 없이도 Eclipse 플러그인 업데이트와 프로젝트 저장이 가능해야 하기 때문입니다.

| 폴더 | 내용 |
|---|---|
| `eclipse` | Eclipse IDE (업그레이드 때 교체됨) |
| `workspace-egov` | eGovFrame 퍼스펙티브가 적용된 워크스페이스 (**업그레이드 때 덮어쓰지 않고, 제거해도 남김**) |
| `notice` | Amateras Modeler 패치 설명 |

패키지는 공식 `eGovFrameDev-5.0.2-Windows-64bit.zip`(약 1.04GB)을 내려받아 SHA-256을 확인한 뒤 설치합니다. 네트워크와 디스크 속도에 따라 설치에 시간이 걸립니다.

## 설치 후 설정

1. **바로가기**: 설치 후 바탕화면에 `eGovFrame` 바로가기가 생성됩니다. 직접 실행하려면 `C:\tools\eGovFrame\eclipse\eclipse.exe`를 실행합니다.
2. **워크스페이스**: 실행하면 `C:\tools\eGovFrame\workspace-egov` 경로가 미리 선택됩니다. 경로를 확인하고 Launch를 클릭합니다.
3. **Java**: eGovFrame 5.0.2는 Java 21 런타임을 포함하고 있어 별도 JDK 없이 Eclipse가 실행되며, 이 패키지는 Java 의존성이 없습니다. Maven, Gradle 등 명령줄 빌드 도구에 JDK 21이 필요하면 `choco install temurin21`처럼 따로 설치합니다.

## 트러블슈팅 (Troubleshooting)

1. **JVM 관련 오류 ("Failed to create the Java Virtual Machine")**:
   설치 경로의 `eclipse\eclipse.ini` 파일을 열어 JDK 21 경로를 다음과 같이 추가해 주세요:
   ```ini
   -vm
   C:\Program Files\Java\jdk-21\bin\javaw.exe
   ```
2. **한글 깨짐 현상**:
   `eclipse.ini` 파일에 `-Dfile.encoding=UTF-8` 설정을 추가하여 이클립스 파일 포맷을 UTF-8로 설정할 수 있습니다.
3. **템플릿 프로젝트 생성 시 일부 DML 파일의 한글 깨짐**: 해당 DML 파일의 인코딩을 EUC-KR로 변경합니다.
4. **런처가 공유 라이브러리를 찾지 못하는 오류**: `eclipse.ini`의 `-startup`, `-launcher.library` 경로를 수정합니다.

## 유지보수 가이드 (GitHub Actions)

본 저장소에는 자동 테스트 및 수동 배포를 위한 GitHub Actions 워크플로우가 포함되어 있습니다.

### 자동 테스트
`main` 브랜치로의 모든 `push` 또는 `PR`은 `windows-latest` 실행 환경에서 패키지 빌드 및 설치 테스트를 자동으로 트리거합니다.

### 수동 배포 (Deployment)
Chocolatey 커뮤니티 저장소에 새 버전을 배포하려면:
1. GitHub 저장소의 **Actions** 탭으로 이동합니다.
2. **Chocolatey Package Test** 워크플로우를 선택합니다.
3. **Run workflow** 버튼을 클릭합니다.
4. **"Chocolatey에 패키지를 배포하시겠습니까?"** 체크박스를 체크하고 **Run workflow**를 실행합니다.
   - *참고: Repository Secrets에 `CHOCOLATEY_API_KEY`가 설정되어 있어야 합니다.*

## 라이선스
eGovFrame은 Apache 2.0 라이선스를 따릅니다.

## 연락처
더 많은 정보는 [eGovFrame 공식 홈페이지](https://www.egovframe.go.kr)를 방문해 주세요.
