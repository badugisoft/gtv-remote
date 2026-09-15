import SwiftUI
import AppKit

@MainActor
final class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {
    private var statusItem: NSStatusItem?
    var window: NSWindow?
    let viewModel = RemoteViewModel()
    private var keyboardMonitor: KeyboardMonitor?

    func applicationDidFinishLaunching(_ notification: Notification) {
        setbuf(stdout, nil)
        setbuf(stderr, nil)
        print("[GTVRemoteApp] Application launched.")
        NSApp.setActivationPolicy(.regular)

        // Ensure dock icon is always explicitly set to our AppIcon
        if let iconImage = NSImage(named: "AppIcon") ?? (Bundle.main.path(forResource: "AppIcon", ofType: "icns").flatMap { NSImage(contentsOfFile: $0) }) {
            NSApp.applicationIconImage = iconImage
        }

        setupStatusItem()
        setupMainWindow()
        self.keyboardMonitor = KeyboardMonitor(viewModel: viewModel)
    }

    private func setupMainWindow() {
        let win = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 280, height: 600),
            styleMask: [.titled, .closable, .miniaturizable, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        win.title = "GTV Remote"
        win.titlebarAppearsTransparent = true
        win.titleVisibility = .hidden
        win.isMovableByWindowBackground = true
        win.isReleasedWhenClosed = false
        win.delegate = self
        win.contentView = NSHostingView(rootView: RemoteControlView(viewModel: viewModel))
        win.center()
        self.window = win

        showMainWindow()
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false // Keep background app running even when window is closed
    }

    private func setupStatusItem() {
        let item = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = item.button {
            button.image = makeMenuBarRemoteIcon()
            button.imagePosition = .imageOnly
            button.target = self
            button.action = #selector(statusItemClicked)
            button.sendAction(on: [.leftMouseUp])
            button.toolTip = "GTV Remote"
        }
        self.statusItem = item
    }

    @objc func statusItemClicked() {
        showMainWindow()
    }

    func showMainWindow() {
        NSApp.activate(ignoringOtherApps: true)
        guard let win = self.window else { return }
        if win.isMiniaturized {
            win.deminiaturize(nil)
        }
        win.makeKeyAndOrderFront(nil)
        win.orderFrontRegardless()
    }

    func windowShouldClose(_ sender: NSWindow) -> Bool {
        // Hide window (orderOut) instead of destroying on close/Cmd+W
        sender.orderOut(nil)
        return false
    }

    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        showMainWindow()
        return false // Prevent default macOS new window creation
    }
}

@main
struct GTVRemoteApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}

/// 45-degree tilted Google TV remote template icon for macOS status bar
private func makeMenuBarRemoteIcon() -> NSImage {
    let size = NSSize(width: 18, height: 18)
    let img = NSImage(size: size, flipped: false) { rect in
        guard let ctx = NSGraphicsContext.current?.cgContext else { return false }

        ctx.setAllowsAntialiasing(true)
        ctx.setShouldAntialias(true)

        ctx.saveGState()
        ctx.translateBy(x: 9, y: 9)
        ctx.rotate(by: CGFloat.pi / 4.0) // 45-degree rotation

        // Remote body (capsule rounded rectangle)
        let bodyWidth: CGFloat = 7.6
        let bodyHeight: CGFloat = 16.0
        let bodyRect = CGRect(x: -bodyWidth/2, y: -bodyHeight/2, width: bodyWidth, height: bodyHeight)
        let bodyRadius: CGFloat = bodyWidth / 2.0

        let bodyPath = CGPath(roundedRect: bodyRect, cornerWidth: bodyRadius, cornerHeight: bodyRadius, transform: nil)

        ctx.setFillColor(NSColor.black.cgColor)
        ctx.addPath(bodyPath)
        ctx.fillPath()

        // Button cutout details (clear blend mode)
        ctx.setBlendMode(.clear)

        // 1. D-Pad upper circular ring
        let dpadRadius: CGFloat = 2.4
        let dpadCenter = CGPoint(x: 0, y: 3.0)
        ctx.addArc(center: dpadCenter, radius: dpadRadius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: false)
        ctx.setLineWidth(0.8)
        ctx.strokePath()

        // 2. D-Pad center dot (OK)
        ctx.addArc(center: dpadCenter, radius: 0.8, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: false)
        ctx.fillPath()

        // 3. Middle buttons (Back, Home)
        let dotRadius: CGFloat = 0.7
        ctx.addArc(center: CGPoint(x: -1.4, y: -0.7), radius: dotRadius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: false)
        ctx.fillPath()
        ctx.addArc(center: CGPoint(x: 1.4, y: -0.7), radius: dotRadius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: false)
        ctx.fillPath()

        // 4. Bottom buttons (Assistant, Mute)
        ctx.addArc(center: CGPoint(x: -1.4, y: -2.8), radius: dotRadius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: false)
        ctx.fillPath()
        ctx.addArc(center: CGPoint(x: 1.4, y: -2.8), radius: dotRadius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: false)
        ctx.fillPath()

        // 5. Lowest power button (pill shape)
        let powerRect = CGRect(x: -1.2, y: -5.3, width: 2.4, height: 1.1)
        let powerPath = CGPath(roundedRect: powerRect, cornerWidth: 0.55, cornerHeight: 0.55, transform: nil)
        ctx.addPath(powerPath)
        ctx.fillPath()

        ctx.restoreGState()
        return true
    }
    img.isTemplate = true
    return img
}
