import Foundation

public struct EnglishStrings: LocalizableStrings {
    public init() {}

    // Connection Status
    public let connecting = "Connecting..."
    public let discovering = "Searching for TVs..."
    public let pairingRequired = "Pairing Required"
    public let disconnected = "Disconnected"
    public let connectionError = "Connection Error"
    public let online = "Online"
    public let selectTVPrompt = "Select TV"

    // Header & Menus
    public let selectDeviceTooltip = "Select TV and manage connections"
    public let shortcutsTooltip = "View keyboard shortcuts"
    public let languageTooltip = "Change language"
    public let deviceList = "Discovered Devices"
    public let searching = "Searching..."
    public let rescanDevices = "Rescan Devices"
    public let disconnect = "Disconnect"
    public let quitApp = "Quit GTV Remote"

    // Remote Control Buttons
    public let powerTooltip = "Power (P)"
    public let playPauseTooltip = "Play/Pause (Space)"
    public let backTooltip = "Back (Esc)"
    public let homeTooltip = "Home (H)"
    public let volumeDownTooltip = "Volume Down (-)"
    public let volumeUpTooltip = "Volume Up (+)"
    public let dpadSelectTooltip = "Select (Enter)"
    public let dpadUpTooltip = "Up (↑)"
    public let dpadDownTooltip = "Down (↓)"
    public let dpadLeftTooltip = "Left (←)"
    public let dpadRightTooltip = "Right (→)"
    public let assistantTooltip = "Google Assistant (A)"
    public let muteTooltip = "Mute (M)"
    public let inputTooltip = "Input Source (I)"

    // Smart Input Bar
    public let inputPlaceholder = "Type to send text to TV..."
    public let send = "Send"

    // Quick Apps
    public let quickApps = "Quick Apps"
    public let quickAppsSettingsTooltip = "Quick Apps Settings"
    public let noAppsSelected = "Select apps in Settings"

    // Quick Apps Settings Sheet
    public let settingsTitle = "Quick Apps Settings"
    public let done = "Done"
    public func listVisibleCount(visible: Int, total: Int) -> String {
        "List (\(visible)/\(total) visible)"
    }
    public let dragToReorder = "Drag to reorder"
    public let addCustomApp = "Add Custom App"
    public let collapse = "Collapse"
    public let appNamePlaceholder = "App Name (e.g. YouTube)"
    public let uriPlaceholder = "Deep Link URI (e.g. https://...)"
    public let add = "Add"
    public let editAppShortcut = "Edit App Shortcut"
    public let appName = "App Name"
    public let deepLinkURI = "Deep Link URI"
    public let cancel = "Cancel"
    public let save = "Save"
    public let edit = "Edit"
    public let delete = "Delete"

    // Pairing Sheet
    public let pairingTitle = "Pair with Google TV"
    public let pairingPrompt = "Enter the 6-character PIN code displayed on your TV screen."
    public let pairingFailed = "Pairing failed. Please verify the code and try again."
    public let pair = "Pair"

    // Keyboard Shortcuts Sheet
    public let shortcutsTitle = "Keyboard Shortcuts"
    public let shortcutsDesc = "The following hotkeys work when the remote window is active."
    public let groupNav = "Navigation & Selection"
    public let groupMedia = "Media & Audio"
    public let groupSystem = "System & Apps"

    public let keyArrow = "Arrow keys (↑ ↓ ← →)"
    public let descArrow = "D-Pad navigation"
    public let keyEnter = "Enter"
    public let descEnter = "Select / OK"
    public let keyEsc = "Esc"
    public let descEsc = "Back"
    public let keyH = "H"
    public let descH = "Go to Home screen"
    public let keySpace = "Space"
    public let descSpace = "Play / Pause"
    public let keyVolume = "+  /  -"
    public let descVolume = "Volume Up / Down"
    public let keyM = "M"
    public let descM = "Toggle Mute"
    public let keyP = "P"
    public let descP = "Power On / Off"
    public let keyA = "A"
    public let descA = "Google Assistant"
    public let keyI = "I"
    public let descI = "Input Source"
    public let keyNumbers = "1 ~ 9"
    public let descNumbers = "Launch Quick App 1 to 9"
}
