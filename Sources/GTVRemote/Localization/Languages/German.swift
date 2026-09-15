import Foundation

public struct GermanStrings: LocalizableStrings {
    public init() {}

    // Connection Status
    public let connecting = "Verbinden..."
    public let discovering = "Suche nach TVs..."
    public let pairingRequired = "Kopplung erforderlich"
    public let disconnected = "Getrennt"
    public let connectionError = "Verbindungsfehler"
    public let online = "Online"
    public let selectTVPrompt = "TV auswählen"

    // Header & Menus
    public let selectDeviceTooltip = "TV auswählen und Verbindung verwalten"
    public let shortcutsTooltip = "Tastaturkurzbefehle anzeigen"
    public let languageTooltip = "Sprache ändern"
    public let deviceList = "Gefundene Geräte"
    public let searching = "Suche..."
    public let rescanDevices = "Geräte neu suchen"
    public let disconnect = "Trennen"
    public let quitApp = "GTV Remote beenden"

    // Remote Control Buttons
    public let powerTooltip = "Ein/Aus (P)"
    public let playPauseTooltip = "Wiedergabe/Pause (Leertaste)"
    public let backTooltip = "Zurück (Esc)"
    public let homeTooltip = "Startseite (H)"
    public let volumeDownTooltip = "Leiser (-)"
    public let volumeUpTooltip = "Lauter (+)"
    public let dpadSelectTooltip = "Auswählen (Enter)"
    public let dpadUpTooltip = "Nach oben (↑)"
    public let dpadDownTooltip = "Nach unten (↓)"
    public let dpadLeftTooltip = "Nach links (←)"
    public let dpadRightTooltip = "Nach rechts (→)"
    public let assistantTooltip = "Google Assistant (A)"
    public let muteTooltip = "Stummschalten (M)"
    public let inputTooltip = "Eingangsquelle (I)"

    // Smart Input Bar
    public let inputPlaceholder = "Text an TV senden..."
    public let send = "Senden"

    // Quick Apps
    public let quickApps = "Schnell-Apps"
    public let quickAppsSettingsTooltip = "Schnell-Apps Einstellungen"
    public let noAppsSelected = "Wählen Sie Apps in den Einstellungen"

    // Quick Apps Settings Sheet
    public let settingsTitle = "Schnell-Apps Einstellungen"
    public let done = "Fertig"
    public func listVisibleCount(visible: Int, total: Int) -> String {
        "Liste (\(visible)/\(total) sichtbar)"
    }
    public let dragToReorder = "Ziehen zum Sortieren"
    public let addCustomApp = "Benutzerdefinierte App hinzufügen"
    public let collapse = "Einklappen"
    public let appNamePlaceholder = "App-Name (z.B. ARD)"
    public let uriPlaceholder = "Deep-Link-URI (z.B. https://...)"
    public let add = "Hinzufügen"
    public let editAppShortcut = "App-Verknüpfung bearbeiten"
    public let appName = "App-Name"
    public let deepLinkURI = "Deep-Link-URI"
    public let cancel = "Abbrechen"
    public let save = "Speichern"
    public let edit = "Bearbeiten"
    public let delete = "Löschen"

    // Pairing Sheet
    public let pairingTitle = "Mit Google TV koppeln"
    public let pairingPrompt = "Geben Sie den auf dem Fernsehbildschirm angezeigten 6-stelligen Code ein."
    public let pairingFailed = "Kopplung fehlgeschlagen. Bitte Code prüfen und erneut versuchen."
    public let pair = "Koppeln"

    // Keyboard Shortcuts Sheet
    public let shortcutsTitle = "Tastaturkurzbefehle"
    public let shortcutsDesc = "Die folgenden Tasten funktionieren, wenn das Fernbedienungsfenster aktiv ist."
    public let groupNav = "Navigation & Auswahl"
    public let groupMedia = "Medien & Audio"
    public let groupSystem = "System & Apps"

    public let keyArrow = "Pfeiltasten (↑ ↓ ← →)"
    public let descArrow = "D-Pad Navigation"
    public let keyEnter = "Eingabetaste"
    public let descEnter = "Auswählen (OK)"
    public let keyEsc = "Esc"
    public let descEsc = "Zurück"
    public let keyH = "H"
    public let descH = "Zur Startseite"
    public let keySpace = "Leertaste"
    public let descSpace = "Wiedergabe / Pause"
    public let keyVolume = "+  /  -"
    public let descVolume = "Lauter / Leiser"
    public let keyM = "M"
    public let descM = "Stummschaltung umschalten"
    public let keyP = "P"
    public let descP = "Ein- / Ausschalten"
    public let keyA = "A"
    public let descA = "Google Assistant aufrufen"
    public let keyI = "I"
    public let descI = "Eingangsquelle wechseln"
    public let keyNumbers = "1 ~ 9"
    public let descNumbers = "Schnell-App 1 bis 9 direkt starten"
}
