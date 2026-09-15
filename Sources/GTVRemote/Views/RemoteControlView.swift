import SwiftUI
import AppKit

public struct RemoteControlView: View {
    @ObservedObject var viewModel: RemoteViewModel
    @StateObject private var shortcutStore = AppShortcutStore.shared
    @ObservedObject private var loc = LocalizationManager.shared
    @State private var showShortcuts: Bool = false
    @State private var showAppSettings: Bool = false
    @FocusState private var isFocused: Bool

    public init(viewModel: RemoteViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        ZStack {
            VisualEffectView(material: .sidebar, blendingMode: .behindWindow)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                // Top Header (Connection Status, Language, Shortcuts)
                topHeaderView

                // Power & Media playback controls
                powerAndAuxRow

                // Directional Pad (Navigation & OK)
                DPadView(viewModel: viewModel)
                    .padding(.vertical, 2)

                // Back and Home controls
                backHomeRow

                // Volume and Mute controls
                volumeRow

                // Quick App shortcuts grid
                mediaAndAppShortcuts

                // Smart text input bar for TV typing
                SmartInputBar(viewModel: viewModel)
            }
            .padding(18)
            .focusable(true)
            .focused($isFocused)
            .focusEffectDisabled()
            .onAppear {
                isFocused = false
            }
        }
        .frame(width: 280, height: windowHeight)
        .sheet(isPresented: $viewModel.isPairingSheetPresented) {
            PairingSheetView(viewModel: viewModel)
        }
        .sheet(isPresented: $showShortcuts) {
            ShortcutsView()
        }
        .sheet(isPresented: $showAppSettings) {
            AppShortcutsSettingsView()
        }
        .sheet(isPresented: $viewModel.showDeviceList) {
            DeviceListSheet(viewModel: viewModel)
        }
    }

    // MARK: - Dynamic Height Calculation

    /// Automatically computes remote window height based on quick app rows count
    private var windowHeight: CGFloat {
        let visible = shortcutStore.visibleItems
        if visible.isEmpty {
            return 548
        }
        let rowCount = (visible.count + 2) / 3
        return 570 + CGFloat(max(0, rowCount - 1)) * 42
    }

    // MARK: - Top Header

    private var topHeaderView: some View {
        HStack(spacing: 6) {
            // TV device selector button
            Button(action: { viewModel.showDeviceList.toggle() }) {
                HStack(spacing: 8) {
                    Circle()
                        .fill(statusColor)
                        .frame(width: 8, height: 8)
                    VStack(alignment: .leading, spacing: 1) {
                        Text(statusTitle)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.primary)
                            .lineLimit(1)
                        Text(statusSubtitle)
                            .font(.system(size: 11))
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Image(systemName: "chevron.up.chevron.down")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(.secondary.opacity(0.8))
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 8)
                .contentShape(Rectangle())
            }
            .buttonStyle(HeaderDeviceButtonStyle())
            .focusable(false)
            .help(L10n.selectDeviceTooltip)

            // Language switcher menu
            Menu {
                ForEach(AppLanguage.allCases) { lang in
                    Button(action: { loc.setLanguage(lang) }) {
                        HStack {
                            Text(lang.displayName)
                            if loc.currentLanguage == lang {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            } label: {
                Image(systemName: "globe")
                    .font(.system(size: 13))
                    .frame(width: 30, height: 30)
            }
            .menuStyle(BorderlessButtonMenuStyle())
            .buttonStyle(HeaderIconButtonStyle())
            .help(L10n.languageTooltip)

            // Keyboard shortcuts reference button
            Button(action: { showShortcuts.toggle() }) {
                Image(systemName: "keyboard")
                    .font(.system(size: 13))
                    .frame(width: 30, height: 30)
            }
            .buttonStyle(HeaderIconButtonStyle())
            .focusable(false)
            .help(L10n.shortcutsTooltip)
        }
    }

    // MARK: - Status Helpers

    private var statusColor: Color {
        switch viewModel.connectionState {
        case .connected:                    return .green
        case .connecting, .pairingRequired: return .orange
        case .disconnected:                 return .gray
        case .error:                        return .red
        default:                            return .gray
        }
    }

    private var statusTitle: String {
        switch viewModel.connectionState {
        case .connected(let name):  return name
        case .connecting:           return L10n.connecting
        case .discovering:          return L10n.discovering
        case .pairingRequired:      return L10n.pairingRequired
        case .disconnected:         return L10n.disconnected
        case .error:                return L10n.connectionError
        }
    }

    private var statusSubtitle: String {
        switch viewModel.connectionState {
        case .connected:        return viewModel.selectedDevice?.host ?? L10n.online
        case .error(let msg):   return msg
        default:                return viewModel.selectedDevice?.host ?? L10n.selectTVPrompt
        }
    }

    // MARK: - Button Rows

    private var powerAndAuxRow: some View {
        HStack(spacing: 12) {
            Button(action: { viewModel.sendKey(.power) }) {
                Image(systemName: "power")
                    .font(.system(size: 14, weight: .medium))
                    .frame(maxWidth: .infinity, minHeight: 36)
            }
            .buttonStyle(RemoteIconButtonStyle(
                baseColor: Color.red.opacity(0.1),
                hoverColor: Color.red.opacity(0.2),
                foregroundColor: .red,
                hoverForegroundColor: .red,
                isExternalPressed: viewModel.activePressedKey == .power
            ))
            .focusable(false)
            .help(L10n.powerTooltip)

            Button(action: { viewModel.sendKey(.playPause) }) {
                Image(systemName: "playpause.fill")
                    .font(.system(size: 14, weight: .medium))
                    .frame(maxWidth: .infinity, minHeight: 36)
            }
            .buttonStyle(RemoteIconButtonStyle(
                baseColor: Color.primary.opacity(0.06),
                hoverColor: Color.primary.opacity(0.12),
                foregroundColor: .primary.opacity(0.8),
                hoverForegroundColor: .primary,
                isExternalPressed: viewModel.activePressedKey == .playPause
            ))
            .focusable(false)
            .help(L10n.playPauseTooltip)
        }
    }

    private var backHomeRow: some View {
        HStack(spacing: 16) {
            Button(action: { viewModel.sendKey(.back) }) {
                Image(systemName: RemoteKey.back.iconName)
                    .font(.system(size: 14, weight: .medium))
                    .frame(maxWidth: .infinity, minHeight: 36)
            }
            .buttonStyle(RemoteIconButtonStyle(
                baseColor: Color.primary.opacity(0.06),
                hoverColor: Color.primary.opacity(0.12),
                foregroundColor: .primary.opacity(0.75),
                hoverForegroundColor: .primary,
                isExternalPressed: viewModel.activePressedKey == .back
            ))
            .focusable(false)
            .help(L10n.backTooltip)

            Button(action: { viewModel.sendKey(.home) }) {
                Image(systemName: RemoteKey.home.iconName)
                    .font(.system(size: 14, weight: .medium))
                    .frame(maxWidth: .infinity, minHeight: 36)
            }
            .buttonStyle(RemoteIconButtonStyle(
                baseColor: Color.primary.opacity(0.06),
                hoverColor: Color.primary.opacity(0.12),
                foregroundColor: .primary.opacity(0.75),
                hoverForegroundColor: .primary,
                isExternalPressed: viewModel.activePressedKey == .home
            ))
            .focusable(false)
            .help(L10n.homeTooltip)
        }
    }

    private var volumeRow: some View {
        HStack(spacing: 10) {
            Button(action: { viewModel.sendKey(.volumeDown) }) {
                Image(systemName: "speaker.wave.1.fill")
                    .font(.system(size: 13, weight: .medium))
                    .frame(maxWidth: .infinity, minHeight: 36)
            }
            .buttonStyle(RemoteIconButtonStyle(
                baseColor: Color.primary.opacity(0.06),
                hoverColor: Color.primary.opacity(0.12),
                foregroundColor: .primary.opacity(0.75),
                hoverForegroundColor: .primary,
                isExternalPressed: viewModel.activePressedKey == .volumeDown
            ))
            .focusable(false)
            .help(L10n.volumeDownTooltip)

            Button(action: { viewModel.sendKey(.volumeMute) }) {
                Image(systemName: "speaker.slash.fill")
                    .font(.system(size: 13, weight: .medium))
                    .frame(maxWidth: .infinity, minHeight: 36)
            }
            .buttonStyle(RemoteIconButtonStyle(
                baseColor: Color.primary.opacity(0.06),
                hoverColor: Color.primary.opacity(0.12),
                foregroundColor: .primary.opacity(0.75),
                hoverForegroundColor: .primary,
                isExternalPressed: viewModel.activePressedKey == .volumeMute
            ))
            .focusable(false)
            .help(L10n.muteTooltip)

            Button(action: { viewModel.sendKey(.volumeUp) }) {
                Image(systemName: "speaker.wave.3.fill")
                    .font(.system(size: 13, weight: .medium))
                    .frame(maxWidth: .infinity, minHeight: 36)
            }
            .buttonStyle(RemoteIconButtonStyle(
                baseColor: Color.primary.opacity(0.06),
                hoverColor: Color.primary.opacity(0.12),
                foregroundColor: .primary.opacity(0.75),
                hoverForegroundColor: .primary,
                isExternalPressed: viewModel.activePressedKey == .volumeUp
            ))
            .focusable(false)
            .help(L10n.volumeUpTooltip)
        }
    }

    // MARK: - App Shortcuts

    private var mediaAndAppShortcuts: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(L10n.quickApps)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(.secondary)
                Spacer()
                Button(action: { showAppSettings.toggle() }) {
                    Image(systemName: "gearshape")
                        .font(.system(size: 11))
                        .frame(width: 22, height: 22)
                }
                .buttonStyle(HeaderIconButtonStyle(cornerRadius: 6))
                .help(L10n.quickAppsSettingsTooltip)
            }

            let visibleApps = shortcutStore.visibleItems
            if visibleApps.isEmpty {
                Text(L10n.noAppsSelected)
                    .font(.system(size: 11))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, minHeight: 28)
                    .background(Color.primary.opacity(0.04))
                    .cornerRadius(6)
            } else {
                // Fixed 3-column grid preserving uniform width
                let columns = [
                    GridItem(.flexible(), spacing: 8),
                    GridItem(.flexible(), spacing: 8),
                    GridItem(.flexible(), spacing: 8)
                ]
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(visibleApps) { app in
                        Button(action: { viewModel.launchApp(name: app.name, uri: app.uri) }) {
                            if app.isCustom {
                                Text(app.name)
                                    .font(.system(size: 11, weight: .semibold))
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.8)
                                    .padding(.horizontal, 4)
                                    .frame(maxWidth: .infinity, minHeight: 34)
                            } else {
                                AppLogoView(app: app)
                                    .frame(maxWidth: .infinity, minHeight: 34)
                            }
                        }
                        .buttonStyle(AppTileButtonStyle())
                        .help(app.name)
                    }
                }
            }
        }
        .padding(.top, 4)
    }
}

// MARK: - VisualEffectView

struct VisualEffectView: NSViewRepresentable {
    let material: NSVisualEffectView.Material
    let blendingMode: NSVisualEffectView.BlendingMode

    func makeNSView(context: Context) -> NSVisualEffectView {
        let v = NSVisualEffectView()
        v.material = material
        v.blendingMode = blendingMode
        v.state = .active
        return v
    }

    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
        nsView.material = material
        nsView.blendingMode = blendingMode
    }
}

// MARK: - AppLogoView

/// Renders app logo via AsyncImage or falls back to SF Symbol
public struct AppLogoView: View {
    let app: AppShortcut

    public init(app: AppShortcut) {
        self.app = app
    }

    public var body: some View {
        if let urlStr = app.logoURL, let url = URL(string: urlStr) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                case .failure, .empty:
                    fallbackIcon
                @unknown default:
                    fallbackIcon
                }
            }
        } else {
            fallbackIcon
        }
    }

    private var fallbackIcon: some View {
        Image(systemName: app.icon)
            .foregroundColor(app.color)
            .font(.system(size: 14))
    }
}

// MARK: - DeviceListSheet

struct DeviceListSheet: View {
    @ObservedObject var viewModel: RemoteViewModel
    @ObservedObject private var loc = LocalizationManager.shared
    @Environment(\.dismiss) private var dismiss
    @State private var manualIP: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text(L10n.deviceList)
                    .font(.headline)
                Spacer()
                Button(L10n.done) { dismiss() }
            }

            if viewModel.discoveredDevices.isEmpty {
                VStack(spacing: 8) {
                    ProgressView().scaleEffect(0.8)
                    Text(L10n.searching)
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, minHeight: 100)
            } else {
                List(viewModel.discoveredDevices) { device in
                    HStack {
                        Image(systemName: "tv").font(.system(size: 16))
                        VStack(alignment: .leading, spacing: 2) {
                            Text(device.name).font(.system(size: 13, weight: .medium))
                            Text(device.host).font(.system(size: 11)).foregroundColor(.secondary)
                        }
                        Spacer()
                        if case .connected = viewModel.connectionState, viewModel.selectedDevice?.id == device.id {
                            Image(systemName: "checkmark").foregroundColor(.blue)
                        }
                    }
                    .padding(.vertical, 4)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.connect(to: device)
                        dismiss()
                    }
                }
                .frame(height: 140)
            }

            VStack(alignment: .leading, spacing: 6) {
                Text("Connect via IP")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(.secondary)
                HStack(spacing: 8) {
                    TextField("192.168.0.2", text: $manualIP)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.system(size: 12))
                    Button("Connect") {
                        let host = manualIP.trimmingCharacters(in: .whitespacesAndNewlines)
                        guard !host.isEmpty else { return }
                        viewModel.addManualDevice(host: host)
                        let dev = DiscoveredDevice(id: host, name: "TV (\(host))", host: host, port: 6466, endpoint: nil)
                        viewModel.connect(to: dev)
                        dismiss()
                    }
                    .disabled(manualIP.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }

            HStack {
                Button(action: {
                    viewModel.startDiscovery()
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "arrow.clockwise")
                        Text(L10n.rescanDevices)
                    }
                    .font(.system(size: 11))
                }
                .buttonStyle(.plain)

                Spacer()

                Button(action: {
                    viewModel.resetPairing()
                    dismiss()
                }) {
                    Text(L10n.disconnect)
                        .font(.system(size: 11))
                        .foregroundColor(.red.opacity(0.8))
                }
                .buttonStyle(.plain)
            }
        }
        .padding(18)
        .frame(width: 320)
    }
}
