# Chocolatey 패키지 공식 배포 가이드라인

이 가이드는 Chocolatey 패키지를 공식적으로 배포하기 위한 절차와 요구 사항을 설명합니다.

## Chocolatey.org 계정 생성

Chocolatey 패키지를 배포하기 위해서는 Chocolatey.org에 계정이 있어야 합니다.

### 절차
1. Chocolatey.org 웹사이트에 접속하여 계정을 생성합니다.
2. 이메일로 전송된 확인 메일을 통해 계정을 활성화합니다.

## 패키지 메타데이터 설정
패키지 메타데이터는 패키지의 이름, 버전, 설명, 저자 등의 정보를 포함합니다. 패키지의 신뢰성과 정확성을 보장하기 위해 메타데이터는 정확하게 작성되어야 합니다.

`egovframe.nuspec` 파일 참고

### 필수 항목
```
- ID: 패키지 고유 식별자. (예: egovframe)
- Version: 패키지의 버전 (예: 1.0.0)
- Title: 패키지 제목.
- Authors: 패키지 저자.
- Owners: 패키지 소유자.
- Description: 패키지에 대한 상세 설명.
- LicenseUrl: 라이선스 URL (예: Apache 2.0 License).
- ProjectUrl: 프로젝트 홈페이지 URL.
- Tags: 패키지를 설명하는 키워드.
```
## 패키지 빌드 및 테스트

### 빌드
패키지를 배포하려면 .nuspec 파일을 기반으로 .nupkg 파일을 생성해야 합니다. 다음 명령어를 사용하여 패키지를 빌드합니다.

``` shell
choco pack
```

### 테스트
패키지를 배포하기 전에 테스트 환경에서 Chocolatey 패키지를 설치하고 작동 여부를 확인합니다.

``` shell
choco install egovframe --version=4.2.0
```

##  API Key 생성 및 패키지 업로드

### API Key 생성
1.	[API 키 관리 페이지](https://community.chocolatey.org/account)에 접속하여 API 키를 확인합니다.
2.	API 키를 복사합니다.

### 패키지 업로드
API 키를 사용하여 패키지를 Chocolatey 저장소에 업로드합니다.

``` shell
choco apikey --key <API 키> --source https://push.chocolatey.org/
choco push egovframe.4.2.0.nupkg --source https://push.chocolatey.org/
```

### 패키지 검토 및 승인
패키지를 업로드하면 Chocolatey 팀에서 패키지를 검토합니다. 검토 과정에서 패키지의 코드, 메타데이터, 의존성 등이 확인되며, 검토가 완료되면 패키지가 공식적으로 배포됩니다. 검토는 일반적으로 몇 시간에서 며칠이 소요될 수 있습니다.

### 패키지 업데이트 및 관리
패키지의 새로운 버전이 릴리스되면, 동일한 절차로 패키지를 업데이트할 수 있습니다. 또한, Chocolatey 계정에서 패키지 상태를 모니터링하고 필요에 따라 수정할 수 있습니다.

### 패키지 업데이트

``` shell
choco pack
choco push egovframe.4.3.0.nupkg --source https://push.chocolatey.org/
```
