# eGovFrame Chocolatey 패키지

## 소개
eGovFrame Chocolatey 패키지에 오신 것을 환영합니다. Chocolatey는 윈도우에서 소프트웨어를 명령줄을 통해 쉽게 설치할 수 있도록 도와주는 패키지 관리자입니다. 이 패키지는 한국 정부에서 개발한 오픈소스 프레임워크인 eGovFrame을 쉽게 설치할 수 있는 방법을 제공합니다. eGovFrame은 공공 부문 애플리케이션 개발을 위해 설계되었으며, 한국에서 IT 프로젝트를 위한 표준화된 플랫폼으로 널리 사용되고 있습니다.

- [eGovFrame 공식 패키지](https://community.chocolatey.org/packages/egovframe)

## eGovFrame에 대하여
- **이름**: eGovFrame (전자표준프레임워크)
- **버전**: 4.3.1
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
choco install egovframe --version=4.3.1
```

### 애플리케이션 설치 경로
기본적으로 eGovFrame은 `C:\Program Files\eGovFrame` 디렉토리에 설치됩니다.

## 설치 후 설정

1. **Eclipse 바로가기**: 설치 후 바탕화면에 Eclipse (eGovFrame IDE) 바로가기가 생성됩니다.
2. **Java 필수 요구 사항**: eGovFrame 4.3.1은 **Java 17 이상**이 필수입니다. Java가 설치되어 있지 않은 경우, `openjdk` 패키지가 의존성으로 자동 설치됩니다.

## 트러블슈팅 (Troubleshooting)

1. **JVM 관련 오류 ("Failed to create the Java Virtual Machine")**:
   설치 경로의 `eclipse.ini` 파일을 열어 JDK 17 경로를 다음과 같이 추가해 주세요:
   ```ini
   -vm
   C:\Program Files\Java\jdk-17.x.x\bin\javaw.exe
   ```
2. **한글 깨짐 현상**:
   `eclipse.ini` 파일에 `-Dfile.encoding=UTF-8` 설정을 추가하여 이클립스 파일 포맷을 UTF-8로 설정할 수 있습니다.

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
