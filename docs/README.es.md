# GTV Remote

<p align="center">
  <img src="../assets/app_icon.png" alt="GTV Remote Icon" width="128" height="128" />
</p>

<p align="center">
  <strong>Un control remoto nativo y moderno para macOS con lanzador rápido de apps para Google TV / Android TV.</strong><br>
  <em>Control TLS bidireccional de baja latencia, detección automática mDNS, escritura instantánea de texto, lanzadores de apps rápidas y atajos de teclado directamente desde tu Mac.</em>
</p>

<p align="center">
  <a href="https://github.com/badugisoft/gtv-remote/releases/latest"><img src="https://img.shields.io/github/v/release/badugisoft/gtv-remote?style=flat-square" alt="Latest Release" /></a>
  <a href="https://github.com/badugisoft/gtv-remote/releases"><img src="https://img.shields.io/github/downloads/badugisoft/gtv-remote/total?style=flat-square" alt="Total Downloads" /></a>
  <a href="https://badugisoft.github.io/gtv-remote/"><img src="https://img.shields.io/badge/Website-GitHub%20Pages-2563eb?style=flat-square" alt="Project Website" /></a>
  <img src="https://img.shields.io/badge/macOS-14.0%2B-black?style=flat-square&logo=apple" alt="macOS 14+" />
  <img src="https://img.shields.io/badge/Swift-6.0%2B-orange?style=flat-square&logo=swift" alt="Swift 6.0+" />
  <img src="https://img.shields.io/badge/Architecture-Apple%20Silicon-blue?style=flat-square" alt="Apple Silicon" />
  <img src="https://img.shields.io/badge/100%25-Built%20with%20Antigravity-blue?style=flat-square" alt="100% Built with Antigravity" />
  <img src="https://img.shields.io/badge/License-MIT-green?style=flat-square" alt="MIT License" />
</p>

<p align="center">
  <a href="../README.md">English</a> ·
  <a href="README.ko.md">한국어</a> ·
  <a href="README.zh-Hans.md">简体中文</a> ·
  <a href="README.ja.md">日本語</a> ·
  <a href="README.de.md">Deutsch</a> ·
  <a href="README.fr.md">Français</a> ·
  <strong>Español</strong>
</p>

<p align="center">
  <a href="https://badugisoft.github.io/gtv-remote/"><strong>🌐 Sitio web del proyecto</strong></a> ·
  <a href="https://github.com/badugisoft/gtv-remote/releases/latest"><strong>⬇️ Descargar última versión</strong></a> ·
  <a href="#capturas-de-pantalla">Capturas</a> ·
  <a href="#características">Características</a> ·
  <a href="#referencia-de-atajos-de-teclado">Atajos</a> ·
  <a href="#instalación">Instalación</a> ·
  <a href="#preguntas-frecuentes-y-solución-de-problemas">FAQ</a> ·
  <a href="#contribuir-y-seguridad">Contribuir</a>
</p>

---

> [!NOTE]
> **🤖 100 % desarrollado con Google Antigravity**
>
> Toda esta aplicación —incluida la comunicación por sockets TLS, la serialización de paquetes Protobuf, el descubrimiento automático mDNS, las vistas SwiftUI, la monitorización de eventos de teclado, la reordenación de apps rápidas mediante arrastrar y soltar, la localización en 7 idiomas y la automatización de compilación— fue **diseñada, implementada y verificada al 100 % en programación autónoma en pareja con Google Antigravity**.

---

## Capturas de pantalla

<p align="center">
  <img src="../assets/remote_main.png" alt="Ventana principal de GTV Remote" height="460" />
  <img src="../assets/quick_apps_settings.png" alt="Ajustes de apps rápidas" height="460" />
  <img src="../assets/keyboard_shortcuts.png" alt="Atajos de teclado" height="460" />
  <br>
  <em>GTV Remote: Interfaz nativa de macOS con vidrio esmerilado, gestor de apps rápidas y atajos de teclado</em>
</p>

---

## Características

- **Experiencia nativa en macOS**:
  - Desarrollada al 100 % con Swift, SwiftUI y AppKit utilizando el material nativo de vidrio esmerilado `.sidebar` (`NSVisualEffectView`).
  - Elegante icono de control remoto inclinado 45 grados en la barra de menús de macOS para abrir o alternar el foco con un clic.
  - La ventana permanece residente en segundo plano al cerrarse; volver a abrirla desde el Dock o la barra de menús es instantáneo sin reiniciar el proceso.

- **Detección de red sin configuración y reconexión instantánea**:
  - Descubrimiento automático Bonjour / mDNS sin configuración de todos los dispositivos Google TV y Android TV en tu red local (`_androidtvremote2._tcp`).
  - Seguimiento en tiempo real de cambios de dirección IP y sincronización automática cuando el televisor cambia de IP mediante DHCP.
  - Límite de seguridad en los reintentos de reconexión para evitar bucles infinitos de conexión.
  - Resolución correcta de nombres de dispositivos con caracteres Unicode e internacionales.
  - Recuerda automáticamente el último televisor conectado y restablece la conexión al instante al iniciar la aplicación.

- **Conexión TLS rápida, segura y privacidad local**:
  - Cifrado TLS mutuo bidireccional seguro compatible con el protocolo Android TV Remote v2.
  - Generación integrada de certificados de cliente RSA-2048 temporales directamente mediante `Security.framework` de Apple (sin necesidad de un binario externo `openssl`).
  - **100 % local y sin telemetría**: todo el tráfico de descubrimiento y control permanece en tu red local Wi-Fi/LAN sin servidores externos ni analíticas. Consulta [SECURITY.md](../SECURITY.md).

- **Navegación completa por teclado y respuesta visual**:
  - Navega por los menús del televisor cómodamente con las teclas de flecha, `Intro`, `Esc`, `Inicio`, `Espacio` y control de volumen.
  - **Animaciones de respuesta en tiempo real de 0,15 s** que resaltan los botones en pantalla al pulsarlos desde el teclado.

- **Entrada de texto inteligente y sincronización del portapapeles**:
  - Barra de entrada inteligente integrada para escribir búsquedas, URLs y contraseñas directamente en tu TV.
  - Pegado en un clic o con `Cmd + V` para enviar el texto del portapapeles de tu Mac directo al campo de entrada del televisor.

- **Lanzador personalizable de apps rápidas**:
  - Preajustes integrados para plataformas populares: **YouTube, Netflix, Disney+, Apple TV, Prime Video, Coupang Play, Max, Paramount+, YouTube TV, Tubi, Pluto TV, Google Play Store, Surfshark, Plex, Spotify, Twitch, Stremio**.
  - Gestor unificado con **reordenación mediante arrastrar y soltar** y casillas de visibilidad.
  - Soporte para añadir, editar y eliminar enlaces profundos personalizados (`https://` o `app://`).
  - Cuadrícula fija de 3 columnas que mantiene dimensiones uniformes en los botones.
  - Accesos numéricos directos (`1` a `9`) para abrir al instante tus apps rápidas principales.

- **Localización multilingüe (7 idiomas)**:
  - Compatible con **English**, **한국어 (coreano)**, **简体中文 (chino simplificado)**, **日本語 (japonés)**, **Deutsch (alemán)**, **Français (francés)** y **Español**.
  - Respeta automáticamente el idioma del sistema macOS en el primer inicio.
  - Botón de globo terráqueo en la cabecera para cambiar el idioma de la interfaz sobre la marcha en cualquier momento.

---

## Referencia de atajos de teclado

Cuando la ventana del control remoto está activa, están disponibles los siguientes atajos físicos:

| Tecla | Función remota | Descripción |
| :--- | :--- | :--- |
| **Flechas (↑ ↓ ← →)** | `DPAD_UP / DOWN / LEFT / RIGHT` | Navegación direccional |
| **Return / Intro** | `DPAD_CENTER` | Seleccionar / OK |
| **Esc / Retroceso** | `BACK` | Atrás / Salir del menú |
| **H** | `HOME` | Ir a la pantalla de inicio del TV |
| **Espacio** | `MEDIA_PLAY_PAUSE` | Reproducir / Pausar |
| **+ / =** | `VOLUME_UP` | Subir volumen |
| **- / _** | `VOLUME_DOWN` | Bajar volumen |
| **M** | `VOLUME_MUTE` | Silenciar / Activar sonido |
| **P** | `POWER` | Encender / Apagar |
| **A** | `ASSISTANT` | Activar Asistente de Google |
| **I** | `INPUT` | Cambiar fuente de entrada de vídeo |
| **1 ~ 9** | App rápida 1–9 | Abrir directamente las apps rápidas 1 a 9 |
| **Cmd + V** | Sincro portapapeles | Enviar el texto del portapapeles del Mac al TV |
| **Cmd + W** | Ocultar ventana | Ocultar la ventana (sigue activa en segundo plano) |

---

## Instalación

### Opción 1: Descargar versión precompilada (Apple Silicon, Recomendado)

1. Descarga el archivo `GTV-Remote-v*.dmg` o `GTV-Remote-v*.zip` más reciente desde [GitHub Releases](https://github.com/badugisoft/gtv-remote/releases/latest).
2. Abre el archivo `.dmg` (o descomprime el `.zip`) y arrastra **GTV Remote.app** a tu carpeta `/Applications` (**Aplicaciones**).
3. Inicia **GTV Remote** desde `/Applications`.

> **Firmado y notarizado:** Las versiones oficiales (`v1.0.5+`) están firmadas con un certificado Apple Developer ID y notarizadas por Apple, por lo que se abren directamente sin advertencias de Gatekeeper. Las versiones precompiladas son para Mac con **Apple Silicon**; los usuarios de Mac Intel deben usar la **Opción 2 (Compilar desde el código fuente)**.

---

### Opción 2: Compilar desde el código fuente (con Makefile)

#### Requisitos previos
- macOS 14.0 (Sonoma) o posterior
- Xcode 16+ o herramientas de línea de comandos Swift 6.0+

#### Compilar e instalar

Clona el repositorio y ejecuta:

```bash
# Compilar binario Release, empaquetar en /Applications/GTV Remote.app e iniciar
make install

# Empaquetar .app, .dmg y .zip dentro de dist/
make package
```

Para limpiar los archivos de compilación:
```bash
make clean
```

Para desinstalar:
```bash
make uninstall
```

---

## Preguntas frecuentes y solución de problemas

<details>
<summary><strong>¿GTV Remote está firmado y notarizado por Apple?</strong></summary>

Sí. Las versiones oficiales a partir de `v1.0.5` están firmadas con Apple Developer ID y notarizadas por Apple, por lo que se abren sin advertencias de Gatekeeper. Si usas una versión anterior (`v1.0.4` o previa), actualiza a la última versión.

</details>

<details>
<summary><strong>Mi Google TV / Android TV no aparece en la lista de dispositivos</strong></summary>

1. Asegúrate de que tu Mac y la TV estén en la misma subred Wi-Fi.
2. Verifica en **Ajustes del Sistema → Privacidad y seguridad → Red local** que **GTV Remote** tenga permiso.
3. Confirma que **Android TV Remote Service** esté activo en la TV y vuelve a buscar dispositivos desde la app.

</details>

<details>
<summary><strong>¿Cómo funcionan los enlaces profundos personalizados en Quick Apps?</strong></summary>

Abre **Ajustes de apps rápidas** para reordenar mediante arrastrar y soltar o añadir apps con URIs `https://` o `app://`. Las 9 primeras apps visibles se abren directamente con las teclas `1` a `9`.

</details>

<details>
<summary><strong>¿GTV Remote recopila datos o se conecta a servidores externos?</strong></summary>

No. Toda la comunicación ocurre exclusivamente en tu red local mediante TLS mutuo y un certificado RSA-2048 generado localmente. Consulta [SECURITY.md](../SECURITY.md).

</details>

<details>
<summary><strong>¿Qué televisores y versiones de macOS son compatibles?</strong></summary>

Cualquier dispositivo compatible con Google TV / Android TV Remote v2 (Chromecast con Google TV, Sony Bravia, TCL, Hisense, Nvidia Shield, etc.) y ordenadores Mac con **macOS 14.0 (Sonoma)** o superior (versiones precompiladas para Apple Silicon; Mac Intel compilando desde el código fuente).

</details>

---

## Estructura del proyecto

```
gtv-remote/
├── .github/
│   ├── ISSUE_TEMPLATE/               # Plantillas de errores y sugerencias
│   ├── PULL_REQUEST_TEMPLATE.md      # Lista de verificación para PR
│   └── workflows/
│       ├── pages.yml                 # Despliegue automatizado de GitHub Pages
│       └── release.yml               # Flujo CI/CD automatizado de lanzamientos
├── AGENTS.md                         # Guías para agentes de IA y desarrolladores
├── CONTRIBUTING.md                   # Guía de contribución y compilación
├── LICENSE                           # Licencia MIT
├── Makefile                          # Script de empaquetado e instalación
├── Package.swift                     # Manifiesto de Swift Package Manager
├── README.md                         # Documentación principal (inglés)
├── SECURITY.md                       # Arquitectura de privacidad y reporte seguro
├── Resources/
│   ├── AppIcon.icns                  # Icono del paquete macOS
│   └── Info.plist                    # Configuración del paquete y permisos
├── Sources/
│   └── GTVRemote/
│       ├── App/                      # Entrada de la app y monitor de teclado
│       │   ├── GTVRemote.swift
│       │   └── KeyboardMonitor.swift
│       ├── Core/
│       │   ├── Network/              # Descubrimiento mDNS y puente TLS NIO
│       │   │   ├── BonjourResolver.swift
│       │   │   ├── DeviceDiscoveryService.swift
│       │   │   ├── TLSSocketBridge.swift
│       │   │   └── TVConnectionManager.swift
│       │   ├── Proto/                # Enlaces de protocolo Protobuf
│       │   │   ├── pairing.pb.swift
│       │   │   └── remote.pb.swift
│       │   └── Security/             # Generación de certificado RSA-2048
│       │       └── CertificateManager.swift
│       ├── Localization/             # Motor de localización en 7 idiomas
│       │   ├── Languages/            # Implementaciones de cadenas por idioma
│       │   ├── L10n.swift
│       │   ├── LocalizableStrings.swift # Protocolo de claves localizadas
│       │   └── LocalizationManager.swift
│       ├── Models/                   # Estructuras de datos y catálogo de apps
│       │   ├── AppShortcut.swift
│       │   ├── Models.swift
│       │   └── RemoteKey.swift
│       ├── ViewModels/               # Lógica de negocio observable del remoto
│       │   └── RemoteViewModel.swift
│       └── Views/                    # Interfaz SwiftUI y paneles
│           ├── Components/
│           │   ├── DPadView.swift
│           │   ├── RemoteButtonStyles.swift
│           │   └── SmartInputBar.swift
│           ├── Sheets/
│           │   ├── AppShortcutsSettingsView.swift
│           │   ├── PairingSheetView.swift
│           │   └── ShortcutsView.swift
│           └── RemoteControlView.swift
├── assets/                           # Capturas de pantalla y recursos multimedia
│   ├── app_icon.png
│   ├── keyboard_shortcuts.png
│   ├── quick_apps_settings.png
│   └── remote_main.png
├── docs/                             # Documentación localizada
│   ├── README.de.md                  # Deutsch
│   ├── README.es.md                  # Español
│   ├── README.fr.md                  # Français
│   ├── README.ja.md                  # 日本語
│   ├── README.ko.md                  # 한국어
│   └── README.zh-Hans.md             # 简体中文
└── site/                             # Sitio web promocional en GitHub Pages
    ├── index.html
    ├── styles.css
    └── i18n.js
```

---

## Contribuir y seguridad

- ¡Las contribuciones son bienvenidas! Consulta [CONTRIBUTING.md](../CONTRIBUTING.md) para ver las instrucciones de compilación, reglas de localización en 7 idiomas y flujo de PR.
- Para conocer nuestra arquitectura de privacidad local o reportar una vulnerabilidad, consulta [SECURITY.md](../SECURITY.md).

---

## Licencia de código abierto

Este proyecto se distribuye bajo la **Licencia MIT**. Consulta el archivo [LICENSE](../LICENSE) para más detalles.
