# Chocolatey 패키지 릴리스 가이드라인

[![English](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/en/outline.svg)](release-guidelines.en.md)
[![한국어](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ko/flat.svg)](release-guidelines.ko.md)
[![Español](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/es/outline.svg)](release-guidelines.es.md)
[![Tiếng Việt](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/vi/outline.svg)](release-guidelines.vi.md)
[![العربية](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ar/outline.svg)](release-guidelines.ar.md)
[![Français](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/fr/outline.svg)](release-guidelines.fr.md)

이 문서는 `egovframe` Chocolatey 패키지를 공식적으로 릴리스, 배포, 검증하기 위한 절차와 요구 사항을 설명합니다.

## Chocolatey.org 계정 준비

Chocolatey 커뮤니티 저장소에 패키지를 배포하려면 Chocolatey.org 계정과 API 키가 필요합니다.

1. [Chocolatey.org](https://community.chocolatey.org/)에서 계정을 생성하고 이메일 인증을 완료합니다.
2. [API 키 관리 페이지](https://community.chocolatey.org/account)에서 API 키를 확인합니다.
3. GitHub 저장소의 **Settings > Secrets and variables > Actions**에 `CHOCOLATEY_API_KEY`라는 이름의 Repository Secret으로 등록합니다.

## 새 버전 릴리스 절차

새 eGovFrame 버전이 공식 발표되면 다음 순서로 패키지를 갱신합니다.

### 1. 패키지 메타데이터 갱신
`egovframe.nuspec` 파일을 열어 다음 항목을 수정합니다:
- `<version>`: 새 버전 번호 (예: `5.0.2`)
- `<releaseNotes>`: 릴리스 변경 사항 요약

### 2. 설치 스크립트 검증 및 갱신
`tools/chocolateyinstall.ps1` 파일을 열어 다운로드 URL과 SHA-256 해시를 갱신합니다:
- 공식 eGovFrame 포털([다운로드 페이지](https://www.egovframe.go.kr/home/sub.do?menuNo=40))에서 제공하는 최신 ZIP 파일의 다운로드 URL과 SHA-256 체크섬을 확인합니다.
- `url64`: 최신 64비트 개발환경 ZIP URL
- `checksum64`: 공식 공시된 SHA-256 체크섬

### 3. 로컬 패키지 빌드 및 테스트
```shell
# 패키지 빌드 (.nupkg 생성)
choco pack

# 로컬 파일로부터 설치 테스트
choco install egovframe --source="'.;https://community.chocolatey.org/api/v2/'" --force -y
```

### 4. 악성코드 사전 검사 (`malware-scan.yml`)
공식 포털 ZIP 파일(~1GB)의 무결성과 보안을 사전에 입증하기 위해 GitHub Actions의 **Malware Scan** 워크플로우를 실행합니다:
1. GitHub 저장소의 **Actions** 탭으로 이동합니다.
2. **Malware Scan** 워크플로우를 선택하고 **Run workflow**를 클릭합니다.
3. 이 워크플로우는 세 가지 증거를 생성합니다:
   - **출처 증증(Provenance)**: 설치 스크립트의 SHA-256 해시 및 포털 공시 MD5/SHA1 대조
   - **Microsoft Defender**: 최신 서명 업데이트 후 전체 검사 (EICAR 양성 대조군 포함)
   - **ClamAV**: 최신 서명 업데이트 후 전체 검사 (EICAR 양성 대조군 포함)

## 패키지 배포 (Deployment)

패키지를 배포하는 방법은 두 가지입니다.

### 방법 1: GitHub Actions 자동 배포 (권장)
1. GitHub 저장소의 **Actions** 탭으로 이동합니다.
2. **Chocolatey Package Test** 워크플로우를 선택합니다.
3. **Run workflow**를 클릭합니다.
4. **"Chocolatey에 패키지를 배포하시겠습니까?"** 체크박스를 선택하고 **Run workflow**를 실행합니다.
5. Windows 러너에서 패키지 빌드 및 설치 테스트를 통과한 후, 등록된 `CHOCOLATEY_API_KEY`를 통해 커뮤니티 저장소로 자동 푸시됩니다.

### 방법 2: 로컬 수동 배포 (CLI)
```shell
choco apikey --key <CHOCOLATEY_API_KEY> --source https://push.chocolatey.org/
choco push egovframe.5.0.2.nupkg --source https://push.chocolatey.org/
```

## 자동 검증기(Verifier) 시간 초과 및 면제(Exemption) 요청

이 패키지는 약 1GB 용량의 공식 ZIP을 설치 중에 다운로드합니다. Chocolatey 자동 검증기(Package Verifier)는 설치 및 제거 명령에 각각 **20분**의 제한 시간을 적용합니다([공식 문서](https://docs.chocolatey.org/en-us/community-repository/moderation/package-verifier/)).

### 면제 요청 대응 지침
- 대용량 파일 특성상 검증기 환경의 네트워크/디스크 속도에 따라 20분 제한 시간을 초과하여 실패할 수 있습니다.
- 패키지 제출 후 검증기 실패 알림이 오면 **15일 이내**에 패키지 페이지 리뷰 코멘트에 **검증기 면제(exempt)** 를 요청해야 합니다 (미응답 시 stale로 자동 거절됨).
- 리뷰 코멘트 작성 시 다음 증거를 첨부합니다:
  1. **GitHub Actions 설치 테스트 결과**: `test.yml` 워크플로우 요약(Step Summary)에 기록된 실제 설치 소요 시간
  2. **보안 검사 결과**: `malware-scan.yml` 워크플로우의 공식 포털 해시 대조 결과 및 Defender / ClamAV 검사 결과
  3. **Chocolatey Test Environment (Vagrant)** 로컬 테스트 성공 로그
