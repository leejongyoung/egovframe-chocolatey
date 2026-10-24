# Chocolatey Package Release Guidelines

[![English](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/en/flat.svg)](release-guidelines.en.md)
[![한국어](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ko/outline.svg)](release-guidelines.ko.md)
[![Español](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/es/outline.svg)](release-guidelines.es.md)
[![Tiếng Việt](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/vi/outline.svg)](release-guidelines.vi.md)
[![العربية](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ar/outline.svg)](release-guidelines.ar.md)
[![Français](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/fr/outline.svg)](release-guidelines.fr.md)

This document explains the procedures and requirements for officially releasing, distributing, and verifying the `egovframe` Chocolatey package.

## Preparing a Chocolatey.org Account

To distribute packages to the Chocolatey Community Repository, you need a Chocolatey.org account and an API key.

1. Create an account at [Chocolatey.org](https://community.chocolatey.org/) and complete email verification.
2. Retrieve your API key from the [API Key Management Page](https://community.chocolatey.org/account).
3. Add it as a Repository Secret named `CHOCOLATEY_API_KEY` under **Settings > Secrets and variables > Actions** in this GitHub repository.

## New Version Release Procedure

When a new eGovFrame version is officially released, update the package using the following steps:

### 1. Update Package Metadata
Open `egovframe.nuspec` and update:
- `<version>`: New version number (e.g. `5.0.2`)
- `<releaseNotes>`: Summary of release changes

### 2. Verify and Update Install Script
Open `tools/chocolateyinstall.ps1` and update download URLs and SHA-256 hashes:
- Verify the download URL and SHA-256 checksum of the latest ZIP from the official [eGovFrame Portal Download Page](https://www.egovframe.go.kr/home/sub.do?menuNo=40).
- `url64`: Latest 64-bit development environment ZIP URL
- `checksum64`: Officially published SHA-256 checksum

### 3. Local Package Build and Test
```shell
# Build package (generates .nupkg)
choco pack

# Test installation from local source
choco install egovframe --source="'.;https://community.chocolatey.org/api/v2/'" --force -y
```

### 4. Pre-release Malware Scan (`malware-scan.yml`)
To prove provenance and security of the ~1 GB official portal ZIP file in advance, run the **Malware Scan** workflow:
1. Go to the **Actions** tab in this GitHub repository.
2. Select the **Malware Scan** workflow and click **Run workflow**.
3. This workflow generates three pieces of evidence:
   - **Provenance**: Compares SHA-256 from the install script with portal-published MD5/SHA1 hashes
   - **Microsoft Defender**: Full scan with updated signatures (including EICAR positive control)
   - **ClamAV**: Full scan with updated signatures (including EICAR positive control)

## Package Deployment

There are two methods to deploy the package.

### Method 1: GitHub Actions Automated Deployment (Recommended)
1. Go to the **Actions** tab in this GitHub repository.
2. Select the **Chocolatey Package Test** workflow.
3. Click **Run workflow**.
4. Check the **"Chocolatey에 패키지를 배포하시겠습니까?"** checkbox and click **Run workflow**.
5. Once build and install tests pass on the Windows runner, the package is automatically pushed to the community repository using the configured `CHOCOLATEY_API_KEY`.

### Method 2: Manual Local Deployment (CLI)
```shell
choco apikey --key <CHOCOLATEY_API_KEY> --source https://push.chocolatey.org/
choco push egovframe.5.0.2.nupkg --source https://push.chocolatey.org/
```

## Package Verifier Timeout and Exemption Requests

During installation, this package downloads an official ZIP file (~1 GB). The Chocolatey Package Verifier limits install and uninstall commands to **20 minutes** each ([official documentation](https://docs.chocolatey.org/en-us/community-repository/moderation/package-verifier/)).

### Verifier Exemption Guidelines
- Due to the large archive size, verification may exceed the 20-minute limit depending on the verifier runner's network and disk performance.
- When you receive a verification failure notification, respond within **15 days** in the package review comments requesting a **verifier exemption (exempt)** (otherwise it is automatically rejected as stale).
- Include the following evidence in your review comment:
  1. **GitHub Actions Test Results**: Actual installation duration recorded in the `test.yml` workflow summary
  2. **Security Scan Results**: MD5/SHA1 hash match results and Defender/ClamAV scan results from `malware-scan.yml`
  3. **Chocolatey Test Environment (Vagrant)** local test success logs
