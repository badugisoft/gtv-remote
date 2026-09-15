import Foundation

/// Remote key codes corresponding to Android TV Remote v2 / Android KeyEvents
public enum RemoteKey: String, CaseIterable, Identifiable, Sendable {
    case dpadUp = "DPAD_UP"
    case dpadDown = "DPAD_DOWN"
    case dpadLeft = "DPAD_LEFT"
    case dpadRight = "DPAD_RIGHT"
    case dpadCenter = "DPAD_CENTER"
    case back = "BACK"
    case home = "HOME"
    case power = "POWER"
    case volumeUp = "VOLUME_UP"
    case volumeDown = "VOLUME_DOWN"
    case volumeMute = "VOLUME_MUTE"
    case playPause = "MEDIA_PLAY_PAUSE"
    case play = "MEDIA_PLAY"
    case pause = "MEDIA_PAUSE"
    case rewind = "MEDIA_REWIND"
    case fastForward = "MEDIA_FAST_FORWARD"
    case settings = "SETTINGS"
    
    public var id: String { rawValue }
    
    public var iconName: String {
        switch self {
        case .dpadUp: return "chevron.up"
        case .dpadDown: return "chevron.down"
        case .dpadLeft: return "chevron.left"
        case .dpadRight: return "chevron.right"
        case .dpadCenter: return "circle.fill"
        case .back: return "arrow.backward"
        case .home: return "house.fill"
        case .power: return "power"
        case .volumeUp: return "speaker.wave.3.fill"
        case .volumeDown: return "speaker.wave.1.fill"
        case .volumeMute: return "speaker.slash.fill"
        case .playPause: return "playpause.fill"
        case .play: return "play.fill"
        case .pause: return "pause.fill"
        case .rewind: return "backward.fill"
        case .fastForward: return "forward.fill"
        case .settings: return "gearshape.fill"
        }
    }
    
    public var label: String {
        switch self {
        case .dpadUp: return "Up"
        case .dpadDown: return "Down"
        case .dpadLeft: return "Left"
        case .dpadRight: return "Right"
        case .dpadCenter: return "Select"
        case .back: return "Back"
        case .home: return "Home"
        case .power: return "Power"
        case .volumeUp: return "Volume +"
        case .volumeDown: return "Volume -"
        case .volumeMute: return "Mute"
        case .playPause: return "Play/Pause"
        case .play: return "Play"
        case .pause: return "Pause"
        case .rewind: return "Rewind"
        case .fastForward: return "Fast Forward"
        case .settings: return "Settings"
        }
    }
}
