import SwiftUI
import AppKit

/// Handles key events when the remote window is key/active
@MainActor
public final class KeyboardMonitor {
    private var localMonitor: Any?
    private weak var viewModel: RemoteViewModel?
    
    public init(viewModel: RemoteViewModel) {
        self.viewModel = viewModel
        startMonitoring()
    }
    
    public func startMonitoring() {
        guard localMonitor == nil else { return }
        
        localMonitor = NSEvent.addLocalMonitorForEvents(matching: [.keyDown, .keyUp]) { [weak self] event in
            guard let self = self, let viewModel = self.viewModel else { return event }
            
            // If any modal sheet (Device list or Pairing pin) is active, do NOT intercept any keys!
            if viewModel.showDeviceList || viewModel.isPairingSheetPresented {
                return event
            }
            
            let isTextInputting: Bool
            if let firstResponder = NSApp.keyWindow?.firstResponder {
                isTextInputting = (firstResponder is NSTextView || firstResponder is NSText)
            } else {
                isTextInputting = false
            }
            
            // If the user is currently editing a textfield:
            if isTextInputting {
                // If it's Escape, blur textfield so arrow keys immediately work!
                if event.type == .keyDown && event.keyCode == 53 { // Escape
                    print("[KeyboardMonitor] Escape pressed -> Unfocusing text field")
                    NSApp.keyWindow?.makeFirstResponder(nil)
                    return nil
                }
                
                // If the textfield is currently empty, arrow keys & Enter should operate the remote!
                if viewModel.inputText.isEmpty {
                    if event.keyCode == 126 || event.keyCode == 125 || event.keyCode == 123 || event.keyCode == 124 || event.keyCode == 36 || event.keyCode == 76 {
                        if event.type == .keyDown {
                            NSApp.keyWindow?.makeFirstResponder(nil)
                        }
                    } else {
                        return event
                    }
                } else {
                    return event
                }
            }
            
            // Handle Cmd+V for clipboard send
            if event.type == .keyDown && event.modifierFlags.contains(.command) && event.charactersIgnoringModifiers == "v" {
                viewModel.sendClipboardText()
                return nil
            }

            // Handle Cmd+W to hide window without terminating
            if event.type == .keyDown && event.modifierFlags.contains(.command) && event.charactersIgnoringModifiers == "w" {
                NSApp.keyWindow?.orderOut(nil)
                return nil
            }
            
            let remoteKey: RemoteKey?
            switch event.keyCode {
            case 126: remoteKey = .dpadUp
            case 125: remoteKey = .dpadDown
            case 123: remoteKey = .dpadLeft
            case 124: remoteKey = .dpadRight
            case 36, 76: remoteKey = .dpadCenter
            case 53, 51: remoteKey = .back
            case 4:   remoteKey = !event.modifierFlags.contains(.command) ? .home : nil
            case 49:  remoteKey = .playPause
            case 24, 69: remoteKey = .volumeUp
            case 27, 78: remoteKey = .volumeDown
            case 46:  remoteKey = !event.modifierFlags.contains(.command) ? .volumeMute : nil
            case 35:  remoteKey = !event.modifierFlags.contains(.command) ? .power : nil
            default:  remoteKey = nil
            }
            
            guard let key = remoteKey else { return event }
            
            if event.type == .keyDown {
                viewModel.sendKey(key)
                return nil
            } else if event.type == .keyUp {
                return nil
            }
            
            return event
        }
    }
    
    public func stopMonitoring() {
        if let monitor = localMonitor {
            NSEvent.removeMonitor(monitor)
            localMonitor = nil
        }
    }
}
