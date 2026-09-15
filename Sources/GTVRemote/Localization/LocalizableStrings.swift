import Foundation

/// Defines all localized string keys required by the application.
/// Implementing this protocol guarantees complete translation coverage at compile time.
public protocol LocalizableStrings: Sendable {
    // Connection Status
    var connecting: String { get }
    var discovering: String { get }
    var pairingRequired: String { get }
    var disconnected: String { get }
    var connectionError: String { get }
    var online: String { get }
    var selectTVPrompt: String { get }

    // Header & Menus
    var selectDeviceTooltip: String { get }
    var shortcutsTooltip: String { get }
    var languageTooltip: String { get }
    var deviceList: String { get }
    var searching: String { get }
    var rescanDevices: String { get }
    var disconnect: String { get }
    var quitApp: String { get }

    // Remote Control Buttons
    var powerTooltip: String { get }
    var playPauseTooltip: String { get }
    var backTooltip: String { get }
    var homeTooltip: String { get }
    var volumeDownTooltip: String { get }
    var volumeUpTooltip: String { get }
    var dpadSelectTooltip: String { get }
    var dpadUpTooltip: String { get }
    var dpadDownTooltip: String { get }
    var dpadLeftTooltip: String { get }
    var dpadRightTooltip: String { get }
    var assistantTooltip: String { get }
    var muteTooltip: String { get }
    var inputTooltip: String { get }

    // Smart Input Bar
    var inputPlaceholder: String { get }
    var send: String { get }

    // Quick Apps
    var quickApps: String { get }
    var quickAppsSettingsTooltip: String { get }
    var noAppsSelected: String { get }

    // Quick Apps Settings Sheet
    var settingsTitle: String { get }
    var done: String { get }
    func listVisibleCount(visible: Int, total: Int) -> String
    var dragToReorder: String { get }
    var addCustomApp: String { get }
    var collapse: String { get }
    var appNamePlaceholder: String { get }
    var uriPlaceholder: String { get }
    var add: String { get }
    var editAppShortcut: String { get }
    var appName: String { get }
    var deepLinkURI: String { get }
    var cancel: String { get }
    var save: String { get }
    var edit: String { get }
    var delete: String { get }

    // Pairing Sheet
    var pairingTitle: String { get }
    var pairingPrompt: String { get }
    var pairingFailed: String { get }
    var pair: String { get }

    // Keyboard Shortcuts Sheet
    var shortcutsTitle: String { get }
    var shortcutsDesc: String { get }
    var groupNav: String { get }
    var groupMedia: String { get }
    var groupSystem: String { get }

    var keyArrow: String { get }
    var descArrow: String { get }
    var keyEnter: String { get }
    var descEnter: String { get }
    var keyEsc: String { get }
    var descEsc: String { get }
    var keyH: String { get }
    var descH: String { get }
    var keySpace: String { get }
    var descSpace: String { get }
    var keyVolume: String { get }
    var descVolume: String { get }
    var keyM: String { get }
    var descM: String { get }
    var keyP: String { get }
    var descP: String { get }
    var keyA: String { get }
    var descA: String { get }
    var keyI: String { get }
    var descI: String { get }
    var keyNumbers: String { get }
    var descNumbers: String { get }
}
