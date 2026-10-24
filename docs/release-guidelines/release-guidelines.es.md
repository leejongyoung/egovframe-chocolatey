# Pautas de publicación del paquete Chocolatey

[![English](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/en/outline.svg)](release-guidelines.en.md)
[![한국어](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ko/outline.svg)](release-guidelines.ko.md)
[![Español](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/es/flat.svg)](release-guidelines.es.md)
[![Tiếng Việt](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/vi/outline.svg)](release-guidelines.vi.md)
[![العربية](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ar/outline.svg)](release-guidelines.ar.md)
[![Français](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/fr/outline.svg)](release-guidelines.fr.md)

Este documento explica los procedimientos y requisitos para publicar, distribuir y verificar oficialmente el paquete Chocolatey `egovframe`.

## Preparación de la cuenta en Chocolatey.org

Para distribuir paquetes en el Repositorio de la Comunidad de Chocolatey, necesita una cuenta en Chocolatey.org y una clave API.

1. Cree una cuenta en [Chocolatey.org](https://community.chocolatey.org/) y complete la verificación por correo electrónico.
2. Obtenga su clave API en la [Página de gestión de claves API](https://community.chocolatey.org/account).
3. Agréguela como Repository Secret con el nombre `CHOCOLATEY_API_KEY` en **Settings > Secrets and variables > Actions** en este repositorio de GitHub.

## Procedimiento de publicación de nueva versión

Cuando se publique oficialmente una nueva versión de eGovFrame, actualice el paquete con los siguientes pasos:

### 1. Actualizar metadatos del paquete
Abra `egovframe.nuspec` y actualice:
- `<version>`: Nuevo número de versión (ej. `5.0.2`)
- `<releaseNotes>`: Resumen de cambios de la versión

### 2. Verificar y actualizar script de instalación
Abra `tools/chocolateyinstall.ps1` y actualice las URLs de descarga y los hashes SHA-256:
- Verifique la URL de descarga y el checksum SHA-256 del archivo ZIP oficial más reciente en la [Página de descargas del portal eGovFrame](https://www.egovframe.go.kr/home/sub.do?menuNo=40).
- `url64`: URL del ZIP del entorno de desarrollo de 64 bits más reciente
- `checksum64`: Suma de comprobación SHA-256 publicada oficialmente

### 3. Compilación y prueba local del paquete
```shell
# Compilar paquete (genera .nupkg)
choco pack

# Probar instalación desde origen local
choco install egovframe --source="'.;https://community.chocolatey.org/api/v2/'" --force -y
```

### 4. Escaneo previo de malware (`malware-scan.yml`)
Para demostrar la procedencia y seguridad del archivo ZIP oficial (~1 GB), ejecute el workflow **Malware Scan**:
1. Vaya a la pestaña **Actions** en este repositorio de GitHub.
2. Seleccione el workflow **Malware Scan** y haga clic en **Run workflow**.
3. Este workflow genera tres pruebas:
   - **Procedencia (Provenance)**: Compara el SHA-256 del script con los hashes MD5/SHA1 del portal
   - **Microsoft Defender**: Escaneo completo con firmas actualizadas (incluye control positivo EICAR)
   - **ClamAV**: Escaneo completo con firmas actualizadas (incluye control positivo EICAR)

## Despliegue del paquete (Deployment)

Hay dos métodos para desplegar el paquete.

### Método 1: Despliegue automatizado con GitHub Actions (Recomendado)
1. Vaya a la pestaña **Actions** en este repositorio de GitHub.
2. Seleccione el workflow **Chocolatey Package Test**.
3. Haga clic en **Run workflow**.
4. Marque la casilla **"Chocolatey에 패키지를 배포하시겠습니까?"** y haga clic en **Run workflow**.
5. Tras superar las pruebas de compilación e instalación en el runner de Windows, el paquete se envía automáticamente usando la `CHOCOLATEY_API_KEY`.

### Método 2: Despliegue manual local (CLI)
```shell
choco apikey --key <CHOCOLATEY_API_KEY> --source https://push.chocolatey.org/
choco push egovframe.5.0.2.nupkg --source https://push.chocolatey.org/
```

## Tiempo de espera del verificador automático y solicitud de exención

Durante la instalación, este paquete descarga un archivo ZIP oficial (~1 GB). El verificador de paquetes de Chocolatey limita los comandos de instalación y desinstalación a **20 minutos** cada uno ([documentación oficial](https://docs.chocolatey.org/en-us/community-repository/moderation/package-verifier/)).

### Pautas para solicitar exención
- Si la verificación falla por tiempo de espera de 20 minutos, responda en un plazo de **15 días** en los comentarios de revisión de la página del paquete solicitando una **exención del verificador (exempt)**.
- Incluya la siguiente evidencia en su comentario:
  1. **Resultados de pruebas de GitHub Actions**: Duración real de instalación en el resumen del workflow `test.yml`
  2. **Resultados de escaneo de seguridad**: Coincidencia de hashes MD5/SHA1 y escaneos de Defender / ClamAV de `malware-scan.yml`
  3. Registros de prueba exitosa en **Chocolatey Test Environment (Vagrant)**
