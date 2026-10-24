# Pautas oficiales de publicación del paquete Chocolatey

[![English](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/en/outline.svg)](release-guidelines.en.md)
[![한국어](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ko/outline.svg)](release-guidelines.ko.md)
[![Español](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/es/flat.svg)](release-guidelines.es.md)
[![Tiếng Việt](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/vi/outline.svg)](release-guidelines.vi.md)
[![العربية](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ar/outline.svg)](release-guidelines.ar.md)
[![Français](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/fr/outline.svg)](release-guidelines.fr.md)

Esta guía explica los procedimientos y requisitos para publicar oficialmente el paquete Chocolatey.

## Creación de una cuenta en Chocolatey.org

Para distribuir paquetes de Chocolatey, debe tener una cuenta en Chocolatey.org.

### Procedimiento
1. Visite el sitio web de Chocolatey.org y cree una cuenta.
2. Active su cuenta mediante el correo de confirmación recibido.

## Configuración de metadatos del paquete
Los metadatos del paquete incluyen nombre, versión, descripción, autores, etc. Para garantizar la confiabilidad y precisión del paquete, los metadatos deben completarse con exactitud.

Consulte el archivo `egovframe.nuspec`.

### Campos obligatorios
```
- ID: Identificador único del paquete (ej. egovframe)
- Version: Versión del paquete (ej. 5.0.2)
- Title: Título del paquete
- Authors: Autores del paquete
- Owners: Propietarios del paquete
- Description: Descripción detallada del paquete
- LicenseUrl: URL de la licencia (ej. Licencia Apache 2.0)
- ProjectUrl: URL de la página principal del proyecto
- Tags: Palabras clave que describen el paquete
```

## Compilación y prueba del paquete

### Compilación
Para distribuir el paquete, genere un archivo `.nupkg` basado en el archivo `.nuspec`:

```shell
choco pack
```

### Prueba
Antes de distribuir, instale el paquete Chocolatey en un entorno de prueba para verificar su funcionamiento:

```shell
choco install egovframe --version=5.0.2
```

## Generación de clave API y carga del paquete

### Generación de clave API
1. Vaya a la [Página de gestión de claves API](https://community.chocolatey.org/account) para obtener su clave API.
2. Copie la clave API.

### Carga del paquete
Cargue el paquete en el repositorio de Chocolatey usando la clave API:

```shell
choco apikey --key <CLAVE_API> --source https://push.chocolatey.org/
choco push egovframe.5.0.2.nupkg --source https://push.chocolatey.org/
```

### Revisión y aprobación del paquete
Una vez cargado, el equipo de Chocolatey revisará el paquete (código, metadatos, dependencias). Una vez aprobado, el paquete se publica oficialmente. Esto suele tardar entre unas horas y varios días.

### Tiempo de espera del verificador automático y solicitud de exención
Este paquete descarga el archivo zip oficial (aprox. 1 GB) durante la instalación. El verificador automático de Chocolatey limita los comandos de instalación/desinstalación a **20 minutos** cada uno ([documentación oficial](https://docs.chocolatey.org/en-us/community-repository/moderation/package-verifier/)).

- Si la verificación falla por tiempo de espera, solicite una **exención del verificador (exempt)** en los comentarios de revisión de la página del paquete. Adjunte los resultados de las pruebas de GitHub Actions y del Chocolatey Test Environment.
- Responda dentro de los 15 días posteriores a la notificación de fallo para evitar el rechazo automático.

### Actualización del paquete
```shell
choco pack
choco push egovframe.5.0.2.nupkg --source https://push.chocolatey.org/
```
