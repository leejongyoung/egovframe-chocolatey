# Official Release Guidelines for Chocolatey Package

[![English](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/en/flat.svg)](release-guidelines.en.md)
[![한국어](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ko/outline.svg)](release-guidelines.ko.md)
[![Español](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/es/outline.svg)](release-guidelines.es.md)
[![Tiếng Việt](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/vi/outline.svg)](release-guidelines.vi.md)
[![العربية](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ar/outline.svg)](release-guidelines.ar.md)
[![Français](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/fr/outline.svg)](release-guidelines.fr.md)

This guide explains the procedures and requirements for officially releasing the Chocolatey package.

## Creating a Chocolatey.org Account

To distribute Chocolatey packages, you must have an account on Chocolatey.org.

### Procedure
1. Visit the Chocolatey.org website and create an account.
2. Activate your account using the confirmation email sent to you.

## Configuring Package Metadata
Package metadata includes information such as package name, version, description, authors, etc. To ensure package reliability and accuracy, metadata must be written precisely.

Refer to the `egovframe.nuspec` file.

### Required Fields
```
- ID: Unique package identifier (e.g. egovframe)
- Version: Package version (e.g. 5.0.2)
- Title: Package title
- Authors: Package authors
- Owners: Package owners
- Description: Detailed package description
- LicenseUrl: License URL (e.g. Apache 2.0 License)
- ProjectUrl: Project homepage URL
- Tags: Keywords describing the package
```

## Building and Testing the Package

### Build
To distribute the package, generate a `.nupkg` file based on the `.nuspec` file. Use the following command to build the package:

```shell
choco pack
```

### Test
Before distributing, install the Chocolatey package in a test environment to verify functionality:

```shell
choco install egovframe --version=5.0.2
```

## Generating API Key and Uploading Package

### Generating API Key
1. Go to the [API Key Management Page](https://community.chocolatey.org/account) to retrieve your API key.
2. Copy the API key.

### Uploading the Package
Upload the package to the Chocolatey repository using the API key:

```shell
choco apikey --key <API_KEY> --source https://push.chocolatey.org/
choco push egovframe.5.0.2.nupkg --source https://push.chocolatey.org/
```

### Package Review and Approval
Once uploaded, the Chocolatey team will review the package. During review, the package's code, metadata, dependencies, etc. are verified. Once approved, the package is officially published. Review typically takes a few hours to several days.

### Automated Verifier Timeout and Exemption Request
This package downloads the official zip (approx. 1 GB) during installation. The Chocolatey automated verifier limits install/uninstall commands to **20 minutes** each ([official documentation](https://docs.chocolatey.org/en-us/community-repository/moderation/package-verifier/)).

- During the 4.3.1 (1.42 GB) submission, the verifier log cut off at the unzip phase after ~11 min download + ~11 min checksum, and a resubmission also cut off at the unzip start. Due to lack of user response, it was rejected for being stale.
- 5.x faces the same constraint. If verification fails after submission, request a **verifier exemption (exempt)** in the review comments on the package page. Provide GitHub Actions install/uninstall test results (installation duration in workflow summary) and Chocolatey Test Environment results.
- When you receive a verification failure notification, respond within 15 days via comment. Failure to respond leads to automatic rejection as stale.

### Package Updates and Maintenance
When a new version of the package is released, update the package following the same procedure. You can also monitor and modify package status in your Chocolatey account.

```shell
choco pack
choco push egovframe.5.0.2.nupkg --source https://push.chocolatey.org/
```
