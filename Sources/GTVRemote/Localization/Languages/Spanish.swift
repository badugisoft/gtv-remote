import Foundation

public struct SpanishStrings: LocalizableStrings {
    public init() {}

    // Connection Status
    public let connecting = "Conectando..."
    public let discovering = "Buscando TVs..."
    public let pairingRequired = "Emparejamiento requerido"
    public let disconnected = "Desconectado"
    public let connectionError = "Error de conexión"
    public let online = "En línea"
    public let selectTVPrompt = "Seleccionar TV"

    // Header & Menus
    public let selectDeviceTooltip = "Seleccionar TV y administrar conexión"
    public let shortcutsTooltip = "Ver atajos de teclado"
    public let languageTooltip = "Cambiar idioma"
    public let deviceList = "Dispositivos encontrados"
    public let searching = "Buscando..."
    public let rescanDevices = "Buscar dispositivos de nuevo"
    public let disconnect = "Desconectar"
    public let quitApp = "Salir de GTV Remote"

    // Remote Control Buttons
    public let powerTooltip = "Encendido (P)"
    public let playPauseTooltip = "Reproducir/Pausar (Espacio)"
    public let backTooltip = "Atrás (Esc)"
    public let homeTooltip = "Inicio (H)"
    public let volumeDownTooltip = "Bajar volumen (-)"
    public let volumeUpTooltip = "Subir volumen (+)"
    public let dpadSelectTooltip = "Seleccionar (Intro)"
    public let dpadUpTooltip = "Arriba (↑)"
    public let dpadDownTooltip = "Abajo (↓)"
    public let dpadLeftTooltip = "Izquierda (←)"
    public let dpadRightTooltip = "Derecha (→)"
    public let assistantTooltip = "Asistente de Google (A)"
    public let muteTooltip = "Silenciar (M)"
    public let inputTooltip = "Entrada (I)"

    // Smart Input Bar
    public let inputPlaceholder = "Escribir texto para enviar a la TV..."
    public let send = "Enviar"

    // Quick Apps
    public let quickApps = "Apps rápidas"
    public let quickAppsSettingsTooltip = "Configuración de apps rápidas"
    public let noAppsSelected = "Selecciona aplicaciones en ajustes"

    // Quick Apps Settings Sheet
    public let settingsTitle = "Ajustes de apps rápidas"
    public let done = "Listo"
    public func listVisibleCount(visible: Int, total: Int) -> String {
        "Lista (\(visible)/\(total) visibles)"
    }
    public let dragToReorder = "Arrastrar para reordenar"
    public let addCustomApp = "Añadir app personalizada"
    public let collapse = "Replegar"
    public let appNamePlaceholder = "Nombre de app (ej: RTVE)"
    public let uriPlaceholder = "URI de enlace profundo (ej: https://...)"
    public let add = "Añadir"
    public let editAppShortcut = "Editar acceso directo"
    public let appName = "Nombre de la aplicación"
    public let deepLinkURI = "URI de enlace profundo"
    public let cancel = "Cancelar"
    public let save = "Guardar"
    public let edit = "Editar"
    public let delete = "Eliminar"

    // Pairing Sheet
    public let pairingTitle = "Emparejar con Google TV"
    public let pairingPrompt = "Introduce el código de 6 caracteres que aparece en tu televisor."
    public let pairingFailed = "Error de emparejamiento. Comprueba el código e inténtalo de nuevo."
    public let pair = "Emparejar"

    // Keyboard Shortcuts Sheet
    public let shortcutsTitle = "Atajos de teclado"
    public let shortcutsDesc = "Las siguientes teclas funcionan cuando la ventana está activa."
    public let groupNav = "Navegación y selección"
    public let groupMedia = "Medios y sonido"
    public let groupSystem = "Sistema y apps"

    public let keyArrow = "Flechas (↑ ↓ ← →)"
    public let descArrow = "Navegación cruceta"
    public let keyEnter = "Intro"
    public let descEnter = "Seleccionar (OK)"
    public let keyEsc = "Esc"
    public let descEsc = "Atrás"
    public let keyH = "H"
    public let descH = "Ir al inicio"
    public let keySpace = "Espacio"
    public let descSpace = "Reproducir / Pausa"
    public let keyVolume = "+  /  -"
    public let descVolume = "Subir / Bajar volumen"
    public let keyM = "M"
    public let descM = "Silenciar"
    public let keyP = "P"
    public let descP = "Encender / Apagar"
    public let keyA = "A"
    public let descA = "Asistente de Google"
    public let keyI = "I"
    public let descI = "Seleccionar entrada"
    public let keyNumbers = "1 ~ 9"
    public let descNumbers = "Iniciar app rápida 1 a 9"
}
