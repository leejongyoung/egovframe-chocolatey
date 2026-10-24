# eGovFrame Chocolatey Package

## Introduction
Welcome to the eGovFrame Chocolatey package. Chocolatey is a package manager for Windows that allows users to install software easily via the command line. This package provides a simple way to install eGovFrame, an open-source framework developed by the government of South Korea. eGovFrame is designed for public sector application development and is widely used as a standardized platform for IT projects in Korea.

- [eGovFrame Official Package](https://community.chocolatey.org/packages/egovframe)

## About eGovFrame
- **Name**: eGovFrame
- **Version**: 5.0.2 (Windows 64-bit development environment, Eclipse 2025-03, Java 21)
- **Description**: eGovFrame is an open-source framework provided by the South Korean government for developing web-based public services. It is built using Java and the Spring framework.
- **Homepage**: [eGovFrame Official Website](https://www.egovframe.go.kr/)

## Installation Guide

### Installing eGovFrame via Chocolatey

Once Chocolatey is installed, you can easily install eGovFrame by running the following command in PowerShell or the command prompt:

```shell
choco install egovframe
```

To install this specific version:
```shell
choco install egovframe --version=5.0.2
```

### Application Installation Path
By default, eGovFrame is installed under the Chocolatey tools location, `C:\tools\eGovFrame` (`$env:ChocolateyToolsLocation\eGovFrame`). This is used instead of Program Files so that Eclipse plug-in updates and your projects are writable without administrator rights.

| Folder | Content |
|---|---|
| `eclipse` | Eclipse IDE (replaced on upgrade) |
| `workspace-egov` | Workspace with the eGovFrame perspective preconfigured (**never overwritten on upgrade, kept on uninstall**) |
| `notice` | Amateras Modeler patch notes |

The package downloads the official `eGovFrameDev-5.0.2-Windows-64bit.zip` (about 1.04 GB), verifies its SHA-256 checksum, and installs it. Installation time depends on your network and disk speed.

## Post Installation Setup

1. **Shortcut**: After installation, an `eGovFrame` shortcut is created on your desktop. You can also run `C:\tools\eGovFrame\eclipse\eclipse.exe` directly.
2. **Workspace**: The launcher preselects `C:\tools\eGovFrame\workspace-egov`. Confirm the path and click Launch.
3. **Java Requirement**: eGovFrame 5.0.2 requires **Java 21 or later**. If Java is not installed, the `openjdk` package will be automatically installed as a dependency.

## Troubleshooting

1. **JVM Error ("Failed to create the Java Virtual Machine")**:
   Edit `eclipse\eclipse.ini` in the installation directory and add the path to your JDK 21:
   ```ini
   -vm
   C:\Program Files\Java\jdk-21\bin\javaw.exe
   ```
2. **Character Encoding Issues**:
   To prevent broken Korean characters, add `-Dfile.encoding=UTF-8` to your `eclipse.ini` file.
3. **Garbled characters in template DML**: Change the encoding of the affected DML file to EUC-KR.
4. **Eclipse launcher cannot find its shared library**: Fix the `-startup` and `-launcher.library` paths in `eclipse.ini`.

## For Maintainers (GitHub Actions)

This repository includes a GitHub Actions workflow for automated testing and manual deployment.

### Automated Testing
Every push or pull request to the `main` branch triggers a build and installation test on a `windows-latest` runner.

### Manual Deployment
To push a new version to the Chocolatey Community Repository:
1. Go to the **Actions** tab in this GitHub repository.
2. Select the **Chocolatey Package Test** workflow.
3. Click **Run workflow**.
4. Check the **"Chocolatey에 패키지를 배포하시겠습니까?"** checkbox and click **Run workflow**.
   - *Note: Requires `CHOCOLATEY_API_KEY` to be set in Repository Secrets.*

## License
eGovFrame is licensed under the Apache 2.0 license.

## Contact
For more information, visit the [eGovFrame Official Website](https://www.egovframe.go.kr).
