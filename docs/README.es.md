# Paquete Chocolatey para eGovFrame

<!-- latest-badge:start -->
[![Marco Estándar de Gobierno Electrónico](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/unversioned/flat-es.svg)](https://www.egovframe.go.kr/)
[![Chocolatey Package Test](https://github.com/leejongyoung/egovframe-chocolatey/actions/workflows/test.yml/badge.svg?branch=main)](https://github.com/leejongyoung/egovframe-chocolatey/actions/workflows/test.yml)
[![Malware Scan](https://github.com/leejongyoung/egovframe-chocolatey/actions/workflows/malware-scan.yml/badge.svg)](https://github.com/leejongyoung/egovframe-chocolatey/actions/workflows/malware-scan.yml)
[![Chocolatey](https://img.shields.io/chocolatey/v/egovframe?label=Chocolatey&logo=chocolatey)](https://community.chocolatey.org/packages/egovframe)
[![License: Apache-2.0](https://img.shields.io/badge/license-Apache--2.0-blue.svg)](../LICENSE)
<!-- latest-badge:end -->

[![English](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/en/outline.svg)](README.en.md)
[![한국어](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ko/outline.svg)](README.ko.md)
[![Español](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/es/flat.svg)](README.es.md)
[![Tiếng Việt](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/vi/outline.svg)](README.vi.md)
[![العربية](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/ar/outline.svg)](README.ar.md)
[![Français](https://raw.githubusercontent.com/leejongyoung/egovframe-badge/main/badges/lang/fr/outline.svg)](README.fr.md)

## Introducción
Bienvenido al paquete Chocolatey de eGovFrame. Chocolatey es un gestor de paquetes para Windows que permite a los usuarios instalar software fácilmente a través de la línea de comandos. Este paquete proporciona una forma sencilla de instalar eGovFrame, un marco de código abierto desarrollado por el gobierno de Corea del Sur. eGovFrame está diseñado para el desarrollo de aplicaciones del sector público y se utiliza ampliamente como plataforma estandarizada para proyectos de TI en Corea.

- [Paquete oficial en Chocolatey](https://community.chocolatey.org/packages/egovframe)

## Acerca de eGovFrame
- **Nombre**: eGovFrame (Marco Estándar de Gobierno Electrónico)
- **Versión**: 5.0.2 (Entorno de desarrollo para Windows de 64 bits, Eclipse 2025-03, Java 21)
- **Descripción**: eGovFrame es un marco de código abierto proporcionado por el gobierno surcoreano para desarrollar servicios públicos basados en web. Está construido con Java y el framework Spring.
- **Sitio web**: [Sitio web oficial de eGovFrame](https://www.egovframe.go.kr/)

## Guía de instalación

### Instalación de eGovFrame a través de Chocolatey

Una vez instalado Chocolatey, puede instalar fácilmente eGovFrame ejecutando el siguiente comando en PowerShell o en el símbolo del sistema:

```shell
choco install egovframe
```

Para instalar esta versión específica:
```shell
choco install egovframe --version=5.0.2
```

### Ruta de instalación de la aplicación
De forma predeterminada, eGovFrame se instala en la ubicación de herramientas de Chocolatey, `C:\tools\eGovFrame` (`$env:ChocolateyToolsLocation\eGovFrame`). Se utiliza esta ruta en lugar de Program Files para que las actualizaciones de complementos de Eclipse y sus proyectos se puedan escribir sin permisos de administrador.

| Carpeta | Contenido |
|---|---|
| `eclipse` | Eclipse IDE (se reemplaza al actualizar) |
| `workspace-egov` | Espacio de trabajo preconfigurado con la perspectiva eGovFrame (**nunca se sobrescribe al actualizar, se conserva al desinstalar**) |
| `notice` | Notas del parche de Amateras Modeler |

El paquete descarga el archivo oficial `eGovFrameDev-5.0.2-Windows-64bit.zip` (aproximadamente 1.04 GB), verifica su suma de comprobación SHA-256 y lo instala. El tiempo de instalación depende de su velocidad de red y disco.

## Configuración posterior a la instalación

1. **Acceso directo**: Tras la instalación, se crea un acceso directo a `eGovFrame` en el escritorio. También puede ejecutar directamente `C:\tools\eGovFrame\eclipse\eclipse.exe`.
2. **Espacio de trabajo**: El iniciador preselecciona `C:\tools\eGovFrame\workspace-egov`. Confirme la ruta y haga clic en Launch.
3. **Java**: eGovFrame 5.0.2 incluye su propio entorno de ejecución Java 21, por lo que Eclipse se inicia sin un JDK independiente y este paquete no depende de Java. Si sus herramientas de compilación (Maven, Gradle, ...) necesitan un JDK 21 en la línea de comandos, instálelo por separado, por ejemplo `choco install temurin21`.

## Solución de problemas (Troubleshooting)

1. **Error de JVM ("Failed to create the Java Virtual Machine")**:
   Edite `eclipse\eclipse.ini` en el directorio de instalación y añada la ruta a su JDK 21:
   ```ini
   -vm
   C:\Program Files\Java\jdk-21\bin\javaw.exe
   ```
2. **Problemas de codificación de caracteres**:
   Para evitar caracteres coreanos dañados, añada `-Dfile.encoding=UTF-8` a su archivo `eclipse.ini`.
3. **Caracteres distorsionados en DML de plantilla**: Cambie la codificación del archivo DML afectado a EUC-KR.
4. **El iniciador de Eclipse no encuentra su biblioteca compartida**: Corrija las rutas `-startup` y `-launcher.library` en `eclipse.ini`.

## Guía de mantenimiento (GitHub Actions)

Este repositorio incluye un flujo de trabajo de GitHub Actions para pruebas automatizadas e implementación manual.

### Pruebas automatizadas
Cada push o pull request a la rama `main` activa una prueba de compilación e instalación en un entorno `windows-latest`.

### Despliegue manual (Deployment)
Para publicar una nueva versión en el repositorio de la comunidad de Chocolatey:
1. Vaya a la pestaña **Actions** en este repositorio de GitHub.
2. Seleccione el flujo de trabajo **Chocolatey Package Test**.
3. Haga clic en **Run workflow**.
4. Marque la casilla **"Chocolatey에 패키지를 배포하시겠습니까?"** y haga clic en **Run workflow**.
   - *Nota: Requiere que `CHOCOLATEY_API_KEY` esté configurado en Repository Secrets.*

## Licencia
eGovFrame está licenciado bajo la licencia Apache 2.0.

## Contacto
Para más información, visite el [Sitio web oficial de eGovFrame](https://www.egovframe.go.kr/).
