# eGovFrame Chocolatey Package

## Introduction
Welcome to the eGovFrame Chocolatey package. Chocolatey is a package manager for Windows that allows users to install software easily via the command line. This package provides a simple way to install eGovFrame, an open-source framework developed by the government of South Korea. eGovFrame is designed for public sector application development and is widely used as a standardized platform for IT projects in Korea.

If you're new to Chocolatey, it's a powerful tool similar to Homebrew on macOS or APT on Linux, which automates software installation on Windows. Chocolatey handles software dependencies, updates, and uninstalls seamlessly.

## About eGovFrame
- **Name**: eGovFrame
- **Description**: eGovFrame is an open-source framework provided by the South Korean government for developing web-based public services. As a government-standardized development platform, it plays a critical role in IT projects in the public sector of Korea and is globally available for use.
- **Homepage**: [eGovFrame Official Website](https://www.egovframe.go.kr/)

## Installation Guide

### Installing Chocolatey
If you don't have Chocolatey installed on your Windows machine, follow these steps:

1. Open PowerShell as Administrator.
2. Run the following command:
``` shell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

For detailed instructions, refer to the Chocolatey Installation Guide.

### Installing eGovFrame via Chocolatey

Once Chocolatey is installed, you can easily install eGovFrame by running the following command in PowerShell or the command prompt:

``` shell
choco install egovframe
```

### Installing Specific Versions

To install a specific version of eGovFrame, you can specify the version number like this:

``` shell
choco install egovframe --version=4.2.0
```

If you omit the version, the latest version will be installed by default.

### Installing eGovFrame from a Local Build

If you’ve made changes to the eGovFrame Chocolatey package and need to build and install it locally, follow these steps:

1.	First, generate the .nupkg package from the nuspec file using the choco pack command. Run the following command in the directory where your .nuspec file is located:

``` shell
choco pack
```

This will create a .nupkg package (e.g., egovframe.4.2.0.nupkg) based on the .nuspec file in the current directory.

2.	Once the package is successfully created, you can install it locally. From the directory where your .nupkg file is located, run the following command:

``` shell
choco install egovframe --source "C:\path\to\your\nupkg\file"
```

Replace "C:\path\to\your\nupkg\file" with the actual path to your .nupkg file. This command tells Chocolatey to install the eGovFrame package from your local build instead of fetching it from an online source.

3.	After the installation is complete, you can verify that the package is installed by running:

``` shell
choco list --local-only
```

This will display all locally installed packages, including eGovFrame.

### Application Installation Path

By default, eGovFrame is installed under the C:\Program Files\eGovFrame directory.

## Post Installation Setup

1. Eclipse Shortcut: After installation, an Eclipse (eGovFrame IDE) shortcut will be created on your desktop.
2. Ensure Java is Installed: eGovFrame requires Java 11 or later. If Java is not installed, OpenJDK 11 will be automatically installed during the installation process.

## Automatic Packaging Updates

This package is configured as an automatic package, meaning that it will automatically be updated when new versions of eGovFrame are released. This ensures that you always have access to the latest features and security updates.

For more information on automatic packages, visit the [Chocolatey Automatic Packaging Documentation](https://docs.chocolatey.org/en-us/create/automatic-packages).

## Shim Generation

Chocolatey automatically shims any executables included in the package or downloaded during installation. Shims allow you to run executables from the command line without specifying their full path.

For example, the eclipse.exe included in eGovFrame will be shimmed automatically, meaning you can run eclipse from any command prompt.

- For GUI applications: Chocolatey will generate a .gui file next to the executable to ensure it is recognized as a GUI application.
- For console applications: Chocolatey automatically handles shimming for console-based applications.

For more details, see [Shim Generation in Chocolatey](https://docs.chocolatey.org/en-us/features/shim).

## Uninstallation Guide

To uninstall eGovFrame, run the following command in PowerShell or the command prompt:

``` shell
choco uninstall egovframe
```

This will remove eGovFrame from your system, including all files and shortcuts.

## License

eGovFrame is licensed under the Apache 2.0 license. For more details, visit the [Apache 2.0 License](/tools/LICENSE.txt).

## Contact

For more information or help, visit the [eGovFrame Official Website](https://www.egovframe.go.kr).