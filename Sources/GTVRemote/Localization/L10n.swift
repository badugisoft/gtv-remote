import Foundation

/// Clean, type-safe accessor for localized strings.
/// Delegates directly to the active `LocalizableStrings` implementation.
@MainActor
public enum L10n {
    public static var current: LocalizableStrings {
        LocalizationManager.shared.strings
    }

    // Connection Status
    public static var connecting: String { current.connecting }
    public static var discovering: String { current.discovering }
    public static var pairingRequired: String { current.pairingRequired }
    public static var disconnected: String { current.disconnected }
    public static var connectionError: String { current.connectionError }
    public static var online: String { current.online }
    public static var selectTVPrompt: String { current.selectTVPrompt }

    // Header & Menus
    public static var selectDeviceTooltip: String { current.selectDeviceTooltip }
    public static var shortcutsTooltip: String { current.shortcutsTooltip }
    public static var languageTooltip: String { current.languageTooltip }
    public static var deviceList: String { current.deviceList }
    public static var searching: String { current.searching }
    public static var rescanDevices: String { current.rescanDevices }
    public static var disconnect: String { current.disconnect }
    public static var quitApp: String { current.quitApp }

    // Remote Control Buttons
    public static var powerTooltip: String { current.powerTooltip }
    public static var playPauseTooltip: String { current.playPauseTooltip }
    public static var backTooltip: String { current.backTooltip }
    public static var homeTooltip: String { current.homeTooltip }
    public static var volumeDownTooltip: String { current.volumeDownTooltip }
    public static var volumeUpTooltip: String { current.volumeUpTooltip }
    public static var dpadSelectTooltip: String { current.dpadSelectTooltip }
    public static var dpadUpTooltip: String { current.dpadUpTooltip }
    public static var dpadDownTooltip: String { current.dpadDownTooltip }
    public static var dpadLeftTooltip: String { current.dpadLeftTooltip }
    public static var dpadRightTooltip: String { current.dpadRightTooltip }
    public static var assistantTooltip: String { current.assistantTooltip }
    public static var muteTooltip: String { current.muteTooltip }
    public static var inputTooltip: String { current.inputTooltip }

    // Smart Input Bar
    public static var inputPlaceholder: String { current.inputPlaceholder }
    public static var send: String { current.send }

    // Quick Apps
    public static var quickApps: String { current.quickApps }
    public static var quickAppsSettingsTooltip: String { current.quickAppsSettingsTooltip }
    public static var noAppsSelected: String { current.noAppsSelected }

    // Quick Apps Settings Sheet
    public static var settingsTitle: String { current.settingsTitle }
    public static var done: String { current.done }
    public static func listVisibleCount(visible: Int, total: Int) -> String {
        current.listVisibleCount(visible: visible, total: total)
    }
    public static var dragToReorder: String { current.dragToReorder }
    public static var addCustomApp: String { current.addCustomApp }
    public static var collapse: String { current.collapse }
    public static var appNamePlaceholder: String { current.appNamePlaceholder }
    public static var uriPlaceholder: String { current.uriPlaceholder }
    public static var add: String { current.add }
    public static var editAppShortcut: String { current.editAppShortcut }
    public static var appName: String { current.appName }
    public static var deepLinkURI: String { current.deepLinkURI }
    public static var cancel: String { current.cancel }
    public static var save: String { current.save }
    public static var edit: String { current.edit }
    public static var delete: String { current.delete }

    // Pairing Sheet
    public static var pairingTitle: String { current.pairingTitle }
    public static var pairingPrompt: String { current.pairingPrompt }
    public static var pairingFailed: String { current.pairingFailed }
    public static var pair: String { current.pair }

    // Keyboard Shortcuts Sheet
    public static var shortcutsTitle: String { current.shortcutsTitle }
    public static var shortcutsDesc: String { current.shortcutsDesc }
    public static var groupNav: String { current.groupNav }
    public static var groupMedia: String { current.groupMedia }
    public static var groupSystem: String { current.groupSystem }

    public static var keyArrow: String { current.keyArrow }
    public static var descArrow: String { current.descArrow }
    public static var keyEnter: String { current.keyEnter }
    public static var descEnter: String { current.descEnter }
    public static var keyEsc: String { current.keyEsc }
    public static var descEsc: String { current.descEsc }
    public static var keyH: String { current.keyH }
    public static var descH: String { current.descH }
    public static var keySpace: String { current.keySpace }
    public static var descSpace: String { current.descSpace }
    public static var keyVolume: String { current.keyVolume }
    public static var descVolume: String { current.descVolume }
    public static var keyM: String { current.keyM }
    public static var descM: String { current.descM }
    public static var keyP: String { current.keyP }
    public static var descP: String { current.descP }
    public static var keyA: String { current.keyA }
    public static var descA: String { current.descA }
    public static var keyI: String { current.keyI }
    public static var descI: String { current.descI }
    public static var keyNumbers: String { current.keyNumbers }
    public static var descNumbers: String { current.descNumbers }
}
