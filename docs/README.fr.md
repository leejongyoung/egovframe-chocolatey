# Package Chocolatey pour eGovFrame

<!-- latest-badge:start -->
[![Cadre standard de l'administration électronique](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/unversioned/flat-fr.svg)](https://www.egovframe.go.kr/)
[![Chocolatey Package Test](https://github.com/leejongyoung/egovframe-chocolatey/actions/workflows/test.yml/badge.svg?branch=main)](https://github.com/leejongyoung/egovframe-chocolatey/actions/workflows/test.yml)
[![Malware Scan](https://github.com/leejongyoung/egovframe-chocolatey/actions/workflows/malware-scan.yml/badge.svg)](https://github.com/leejongyoung/egovframe-chocolatey/actions/workflows/malware-scan.yml)
[![Chocolatey](https://img.shields.io/chocolatey/v/egovframe?label=Chocolatey&logo=chocolatey)](https://community.chocolatey.org/packages/egovframe)
[![License: Apache-2.0](https://img.shields.io/badge/license-Apache--2.0-blue.svg)](../LICENSE)
<!-- latest-badge:end -->

[![English](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/en/outline.svg)](README.en.md)
[![한국어](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ko/outline.svg)](README.ko.md)
[![Español](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/es/outline.svg)](README.es.md)
[![Tiếng Việt](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/vi/outline.svg)](README.vi.md)
[![العربية](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ar/outline.svg)](README.ar.md)
[![Français](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/fr/flat.svg)](README.fr.md)

## Introduction
Bienvenue dans le package Chocolatey d'eGovFrame. Chocolatey est un gestionnaire de packages pour Windows qui permet aux utilisateurs d'installer facilement des logiciels via la ligne de commande. Ce package offre un moyen simple d'installer eGovFrame, un framework open source développé par le gouvernement sud-coréen. eGovFrame est conçu pour le développement d'applications du secteur public et est largement utilisé comme plateforme standardisée pour les projets informatiques en Corée.

- [Package officiel sur Chocolatey](https://community.chocolatey.org/packages/egovframe)

## À propos d'eGovFrame
- **Nom** : eGovFrame (Cadre standard de l'administration électronique)
- **Version** : 5.0.2 (Environnement de développement Windows 64 bits, Eclipse 2025-03, Java 21)
- **Description** : eGovFrame est un framework open source fourni par le gouvernement sud-coréen pour développer des services publics en ligne. Il est construit avec Java et le framework Spring.
- **Site web** : [Site officiel d'eGovFrame](https://www.egovframe.go.kr/)

## Guide d'installation

### Installation d'eGovFrame via Chocolatey

Une fois Chocolatey installé, vous pouvez facilement installer eGovFrame en exécutant la commande suivante dans PowerShell ou l'invite de commandes :

```shell
choco install egovframe
```

Pour installer cette version spécifique :
```shell
choco install egovframe --version=5.0.2
```

### Chemin d'installation de l'application
Par défaut, eGovFrame est installé dans l'emplacement des outils Chocolatey, `C:\tools\eGovFrame` (`$env:ChocolateyToolsLocation\eGovFrame`). Cet emplacement est utilisé à la place de Program Files afin que les mises à jour des plug-ins Eclipse et vos projets soient accessibles en écriture sans droits d'administrateur.

| Dossier | Contenu |
|---|---|
| `eclipse` | Eclipse IDE (remplacé lors de la mise à niveau) |
| `workspace-egov` | Espace de travail préconfiguré avec la perspective eGovFrame (**jamais écrasé lors de la mise à niveau, conservé lors de la désinstallation**) |
| `notice` | Notes de mise à jour d'Amateras Modeler |

Le package télécharge l'archive officielle `eGovFrameDev-5.0.2-Windows-64bit.zip` (environ 1.04 Go), vérifie son empreinte SHA-256 et l'installe. Le temps d'installation dépend de la vitesse de votre réseau et de votre disque.

## Configuration post-installation

1. **Raccourci** : Après l'installation, un raccourci `eGovFrame` est créé sur votre bureau. Vous pouvez également exécuter directement `C:\tools\eGovFrame\eclipse\eclipse.exe`.
2. **Espace de travail** : Le lanceur présélectionne `C:\tools\eGovFrame\workspace-egov`. Confirmez le chemin et cliquez sur Launch.
3. **Java** : eGovFrame 5.0.2 intègre son propre environnement d'exécution Java 21, donc Eclipse démarre sans JDK distinct et ce package ne dépend pas de Java. Si vos outils de build (Maven, Gradle, ...) nécessitent un JDK 21 en ligne de commande, installez-en un séparément, par exemple `choco install temurin21`.

## Dépannage (Troubleshooting)

1. **Erreur JVM ("Failed to create the Java Virtual Machine")** :
   Modifiez `eclipse\eclipse.ini` dans le répertoire d'installation et ajoutez le chemin vers votre JDK 21 :
   ```ini
   -vm
   C:\Program Files\Java\jdk-21\bin\javaw.exe
   ```
2. **Problèmes d'encodage des caractères** :
   Pour éviter l'affichage de caractères coréens corrompus, ajoutez `-Dfile.encoding=UTF-8` à votre fichier `eclipse.ini`.
3. **Caractères corrompus dans le fichier DML du modèle** : Changez l'encodage du fichier DML affecté en EUC-KR.
4. **Le lanceur Eclipse ne trouve pas sa bibliothèque partagée** : Corrigez les chemins `-startup` et `-launcher.library` dans `eclipse.ini`.

## Guide de maintenance (GitHub Actions)

Ce dépôt comprend un workflow GitHub Actions pour les tests automatisés et le déploiement manuel.

### Tests automatisés
Chaque push ou pull request vers la branche `main` déclenche un test de build et d'installation sur un exécuteur `windows-latest`.

### Déploiement manuel (Deployment)
Pour publier une nouvelle version sur le Chocolatey Community Repository :
1. Accédez à l'onglet **Actions** de ce dépôt GitHub.
2. Sélectionnez le workflow **Chocolatey Package Test**.
3. Cliquez sur **Run workflow**.
4. Cochez la case **"Chocolatey에 패키지를 배포하시겠습니까?"** et cliquez sur **Run workflow**.
   - *Remarque : Nécessite que `CHOCOLATEY_API_KEY` soit configuré dans les secrets du dépôt.*

## Licence
eGovFrame est distribué sous licence Apache 2.0.

## Contact
Pour plus d'informations, visitez le [Site officiel d'eGovFrame](https://www.egovframe.go.kr/).
