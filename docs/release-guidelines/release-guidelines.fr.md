# Lignes directrices de publication du package Chocolatey

[![English](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/en/outline.svg)](release-guidelines.en.md)
[![한국어](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ko/outline.svg)](release-guidelines.ko.md)
[![Español](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/es/outline.svg)](release-guidelines.es.md)
[![Tiếng Việt](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/vi/outline.svg)](release-guidelines.vi.md)
[![العربية](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ar/outline.svg)](release-guidelines.ar.md)
[![Français](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/fr/flat.svg)](release-guidelines.fr.md)

Ce document explique les procédures et les exigences pour publier, distribuer et vérifier officiellement le package Chocolatey `egovframe`.

## Préparation du compte Chocolatey.org

Pour distribuer des packages sur le Chocolatey Community Repository, vous avez besoin d'un compte sur Chocolatey.org et d'une clé API.

1. Créez un compte sur [Chocolatey.org](https://community.chocolatey.org/) et validez votre adresse e-mail.
2. Récupérez votre clé API sur la [page de gestion des clés API](https://community.chocolatey.org/account).
3. Ajoutez-la en tant que Repository Secret nommé `CHOCOLATEY_API_KEY` sous **Settings > Secrets and variables > Actions** dans ce dépôt GitHub.

## Procédure de publication d'une nouvelle version

Lorsqu'une nouvelle version d'eGovFrame est officiellement publiée, mettez à jour le package en suivant ces étapes :

### 1. Mettre à jour les métadonnées du package
Ouvrez `egovframe.nuspec` et mettez à jour :
- `<version>` : Nouveau numéro de version (ex. `5.0.2`)
- `<releaseNotes>` : Résumé des changements de la version

### 2. Vérifier et mettre à jour le script d'installation
Ouvrez `tools/chocolateyinstall.ps1` et mettez à jour les URL de téléchargement et les empreintes SHA-256 :
- Vérifiez l'URL et le checksum SHA-256 de la dernière archive ZIP sur la [page de téléchargement du portail eGovFrame](https://www.egovframe.go.kr/home/sub.do?menuNo=40).
- `url64` : URL de la dernière archive ZIP pour environnement 64 bits
- `checksum64` : Empreinte SHA-256 officielle

### 3. Compilation et test local du package
```shell
# Compiler le package (.nupkg)
choco pack

# Tester l'installation à partir de la source locale
choco install egovframe --source="'.;https://community.chocolatey.org/api/v2/'" --force -y
```

### 4. Analyse antivirus préalable (`malware-scan.yml`)
Pour prouver la provenance et la sécurité de l'archive ZIP officielle (~1 Go) à l'avance, exécutez le workflow **Malware Scan** :
1. Accédez à l'onglet **Actions** de ce dépôt GitHub.
2. Sélectionnez le workflow **Malware Scan** et cliquez sur **Run workflow**.
3. Ce workflow génère trois preuves :
   - **Provenance** : Comparaison du SHA-256 avec les empreintes MD5/SHA1 publiées par le portail
   - **Microsoft Defender** : Analyse complète avec signatures à jour (incluant le contrôle positif EICAR)
   - **ClamAV** : Analyse complète avec signatures à jour (incluant le contrôle positif EICAR)

## Déploiement du package

Deux méthodes permettent de déployer le package.

### Méthode 1 : Déploiement automatisé via GitHub Actions (Recommandé)
1. Accédez à l'onglet **Actions** de ce dépôt GitHub.
2. Sélectionnez le workflow **Chocolatey Package Test**.
3. Cliquez sur **Run workflow**.
4. Cochez la case **"Chocolatey에 패키지를 배포하시겠습니까?"** et cliquez sur **Run workflow**.
5. Après réussite des tests de compilation et d'installation sur Windows, le package est automatiquement poussé vers le dépôt communautaire à l'aide de `CHOCOLATEY_API_KEY`.

### Méthode 2 : Déploiement manuel local (CLI)
```shell
choco apikey --key <CHOCOLATEY_API_KEY> --source https://push.chocolatey.org/
choco push egovframe.5.0.2.nupkg --source https://push.chocolatey.org/
```

## Délai d'attente du vérificateur automatisé et demandes d'exemption

Ce package télécharge une archive ZIP officielle (~1 Go) lors de l'installation. Le vérificateur de package Chocolatey limite les commandes d'installation et de désinstallation à **20 minutes** chacune ([documentation officielle](https://docs.chocolatey.org/en-us/community-repository/moderation/package-verifier/)).

### Lignes directrices pour la demande d'exemption
- En raison de la taille de l'archive, la vérification peut dépasser le délai de 20 minutes selon les performances réseau et disque du serveur de vérification.
- En cas de notification d'échec, répondez dans les **15 jours** dans les commentaires de révision pour demander une **exemption de vérificateur (exempt)** (sinon le package est rejeté pour inactivité).
- Joignez les preuves suivantes à votre commentaire :
  1. **Résultats des tests GitHub Actions** : Durée réelle d'installation consignée dans le résumé du workflow `test.yml`
  2. **Résultats de l'analyse antivirus** : Correspondance des empreintes MD5/SHA1 et résultats Defender / ClamAV issus de `malware-scan.yml`
  3. Journaux de test réussi dans le **Chocolatey Test Environment (Vagrant)**
