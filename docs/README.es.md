# GTV Remote

<p align="center">
  <img src="../assets/app_icon.png" alt="GTV Remote Icon" width="128" height="128" />
</p>

<p align="center">
  <strong>Un control remoto nativo y moderno para macOS con lanzador rápido de apps para Google TV / Android TV.</strong><br>
  <em>Control TLS bidireccional de baja latencia, detección automática mDNS, escritura instantánea de texto, lanzadores de apps rápidas y atajos de teclado directamente desde tu Mac.</em>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/macOS-14.0%2B-black?style=flat-square&logo=apple" alt="macOS 14+" />
  <img src="https://img.shields.io/badge/Swift-6.0%2B-orange?style=flat-square&logo=swift" alt="Swift 6.0+" />
  <img src="https://img.shields.io/badge/Architecture-Apple%20Silicon%20%7C%20Intel-blue?style=flat-square" alt="Apple Silicon & Intel" />
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

- **Conexión TLS rápida y segura**:
  - Cifrado TLS mutuo bidireccional seguro compatible con el protocolo Android TV Remote v2.
  - Generación integrada de certificados de cliente RSA-2048 temporales directamente mediante `Security.framework` de Apple (sin necesidad de un binario externo `openssl`).

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

### Opción 1: Descargar versión precompilada (Recomendado)

1. Descarga el archivo `GTV-Remote-v*.dmg` o `GTV-Remote-v*.zip` más reciente desde [GitHub Releases](https://github.com/badugisoft/gtv-remote/releases/latest).
2. Abre el archivo `.dmg` (o descomprime el `.zip`) y arrastra **GTV Remote.app** a tu carpeta `/Applications` (**Aplicaciones**).
3. Inicia **GTV Remote** desde `/Applications`.

#### Solucionar la advertencia de desarrollador no verificado / certificado en macOS (Gatekeeper)

Debido a que **GTV Remote** está firmado de forma ad-hoc sin un certificado de pago Apple Developer ID, macOS puede mostrar una advertencia la primera vez que lo abras (*«Apple no pudo verificar que «GTV Remote.app» esté libre de software malicioso»* o *«no se puede abrir porque no se puede verificar el desarrollador»*).

**Método A — desde Ajustes del Sistema (interfaz gráfica):**

1. Intenta abrir **GTV Remote.app** una vez y haz clic en **Aceptar** (o **Cancelar**) en el aviso.
2. Abre **Ajustes del Sistema** → **Privacidad y seguridad**.
3. Desplázate hacia abajo hasta la sección **Seguridad** y haz clic en **Abrir de todas formas** junto al mensaje que indica que se bloqueó el uso de `«GTV Remote.app»`.
4. Confirma haciendo clic en **Abrir de todas formas** (o **Abrir**) e introduce la contraseña de tu Mac o usa Touch ID.

**Método B — desde la Terminal:**

```bash
xattr -cr "/Applications/GTV Remote.app"
```

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

## Estructura del proyecto

```
gtv-remote/
├── .github/workflows/release.yml     # Flujo CI/CD automatizado de lanzamientos
├── AGENTS.md                         # Guías para agentes de IA y desarrolladores
├── Makefile                          # Script de empaquetado e instalación
├── Package.swift                     # Manifiesto de Swift Package Manager
├── LICENSE                           # Licencia MIT
├── README.md                         # Documentación principal (inglés)
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
└── docs/                             # Documentación localizada
    ├── README.de.md                  # Deutsch
    ├── README.es.md                  # Español
    ├── README.fr.md                  # Français
    ├── README.ja.md                  # 日本語
    ├── README.ko.md                  # 한국어
    └── README.zh-Hans.md             # 简体中文
```

---

## Licencia de código abierto

Este proyecto se distribuye bajo la **Licencia MIT**. Consulta el archivo [LICENSE](../LICENSE) para más detalles.
