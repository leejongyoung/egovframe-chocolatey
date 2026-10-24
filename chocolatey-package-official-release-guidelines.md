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
choco install egovframe --version=5.0.2
```

##  API Key 생성 및 패키지 업로드

### API Key 생성
1.	[API 키 관리 페이지](https://community.chocolatey.org/account)에 접속하여 API 키를 확인합니다.
2.	API 키를 복사합니다.

### 패키지 업로드
API 키를 사용하여 패키지를 Chocolatey 저장소에 업로드합니다.

``` shell
choco apikey --key <API 키> --source https://push.chocolatey.org/
choco push egovframe.5.0.2.nupkg --source https://push.chocolatey.org/
```

### 패키지 검토 및 승인
패키지를 업로드하면 Chocolatey 팀에서 패키지를 검토합니다. 검토 과정에서 패키지의 코드, 메타데이터, 의존성 등이 확인되며, 검토가 완료되면 패키지가 공식적으로 배포됩니다. 검토는 일반적으로 몇 시간에서 며칠이 소요될 수 있습니다.

### 자동 검증(verifier) 시간 초과와 면제 요청
이 패키지는 설치 때 약 1GB의 공식 zip을 내려받습니다. Chocolatey 자동 검증기(verifier)는 install/uninstall 명령을 각각 **20분**으로 제한합니다([공식 문서](https://docs.chocolatey.org/en-us/community-repository/moderation/package-verifier/)).

- 4.3.1(1.42GB) 제출 때 검증기 로그에서 다운로드 약 11분 + 체크섬 약 11분 후 압축 해제 단계에서 끝났고, 4월 재제출에서도 압축 해제 시작 시점에서 로그가 끝났습니다. 이후 사용자 응답이 없어 2026-05-30에 stale 사유로 rejected 되었습니다.
- 5.x도 같은 제약이 남아 있으므로, 제출 뒤 검증이 실패하면 패키지 페이지의 리뷰 코멘트에서 **검증기 면제(exempt)** 를 요청합니다. 그때 GitHub Actions 설치·제거 테스트 결과(워크플로우 요약의 설치 소요 시간)와 Chocolatey Test Environment 테스트 결과를 함께 적습니다.
- 검증 실패 알림을 받으면 15일 안에 코멘트로 응답합니다. 응답하지 않으면 stale로 자동 rejected 됩니다.

### 패키지 업데이트 및 관리
패키지의 새로운 버전이 릴리스되면, 동일한 절차로 패키지를 업데이트할 수 있습니다. 또한, Chocolatey 계정에서 패키지 상태를 모니터링하고 필요에 따라 수정할 수 있습니다.

### 패키지 업데이트

``` shell
choco pack
choco push egovframe.5.0.2.nupkg --source https://push.chocolatey.org/
```
