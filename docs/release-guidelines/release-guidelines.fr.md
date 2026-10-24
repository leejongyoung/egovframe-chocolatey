# Lignes directrices de publication officielle du package Chocolatey

[![English](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/en/outline.svg)](release-guidelines.en.md)
[![한국어](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ko/outline.svg)](release-guidelines.ko.md)
[![Español](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/es/outline.svg)](release-guidelines.es.md)
[![Tiếng Việt](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/vi/outline.svg)](release-guidelines.vi.md)
[![العربية](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ar/outline.svg)](release-guidelines.ar.md)
[![Français](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/fr/flat.svg)](release-guidelines.fr.md)

Ce guide explique les procédures et les exigences pour publier officiellement le package Chocolatey.

## Création d'un compte Chocolatey.org
Pour distribuer des packages Chocolatey, vous devez disposer d'un compte sur Chocolatey.org.

### Procédure
1. Rendez-vous sur le site Chocolatey.org et créez un compte.
2. Activez votre compte à l'aide de l'e-mail de confirmation.

## Configuration des métadonnées du package
Les métadonnées comprennent le nom, la version, la description, les auteurs, etc. Consultez le fichier `egovframe.nuspec`.

### Champs obligatoires
```
- ID : Identifiant unique du package (ex. egovframe)
- Version : Version du package (ex. 5.0.2)
- Title : Titre du package
- Authors : Auteurs du package
- Owners : Propriétaires du package
- Description : Description détaillée du package
- LicenseUrl : URL de la licence (ex. Licence Apache 2.0)
- ProjectUrl : URL de la page du projet
- Tags : Mots-clés décrivant le package
```

## Compilation et test du package

### Compilation
```shell
choco pack
```

### Test
```shell
choco install egovframe --version=5.0.2
```

## Génération de la clé API et téléversement

### Génération de la clé API
1. Accédez à la [page de gestion des clés API](https://community.chocolatey.org/account).
2. Copiez votre clé API.

### Téléversement du package
```shell
choco apikey --key <CLE_API> --source https://push.chocolatey.org/
choco push egovframe.5.0.2.nupkg --source https://push.chocolatey.org/
```

### Révision et approbation
L'équipe Chocolatey vérifie le code, les métadonnées et les dépendances avant publication officielle.

### Délai d'attente du vérificateur automatisé et demande d'exemption
Ce package télécharge l'archive officielle (environ 1 Go) lors de l'installation. Le vérificateur automatique limite les commandes d'installation/désinstallation à **20 minutes** chacune.
- En cas d'échec pour dépassement de délai, demandez une **exemption de vérificateur (exempt)** dans les commentaires de révision en joignant les résultats des tests GitHub Actions et de l'environnement de test Chocolatey.
- Répondez dans les 15 jours suivant la notification pour éviter un rejet automatique.

### Mise à jour du package
```shell
choco pack
choco push egovframe.5.0.2.nupkg --source https://push.chocolatey.org/
```
