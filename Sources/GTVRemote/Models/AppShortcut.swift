import SwiftUI

// MARK: - Model

public struct AppShortcut: Identifiable, Codable, Equatable, Sendable {
    public var id: String
    public var name: String
    public var icon: String       // SF Symbol fallback
    public var colorHex: String
    public var uri: String
    public var logoURL: String?   // Official logo URL (nil falls back to SF Symbol)
    public var isCustom: Bool     // Whether this is a user-added custom app
    public var isVisible: Bool    // Whether this is displayed on the main remote

    public var color: Color {
        Color(hex: colorHex) ?? .blue
    }

    public init(
        id: String = UUID().uuidString,
        name: String,
        icon: String = "app.fill",
        colorHex: String = "#888888",
        uri: String,
        logoURL: String? = nil,
        isCustom: Bool = false,
        isVisible: Bool = true
    ) {
        self.id = id
        self.name = name
        self.icon = icon
        self.colorHex = colorHex
        self.uri = uri
        self.logoURL = logoURL
        self.isCustom = isCustom
        self.isVisible = isVisible
    }

    enum CodingKeys: String, CodingKey {
        case id, name, icon, colorHex, uri, logoURL, isCustom, isVisible
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        self.name = try container.decode(String.self, forKey: .name)
        self.icon = try container.decodeIfPresent(String.self, forKey: .icon) ?? "app.fill"
        self.colorHex = try container.decodeIfPresent(String.self, forKey: .colorHex) ?? "#888888"
        self.uri = try container.decode(String.self, forKey: .uri)
        self.logoURL = try container.decodeIfPresent(String.self, forKey: .logoURL)
        
        // Preset check: if ID doesn't start with preset_, treat as custom
        let defaultIsCustom = !self.id.hasPrefix("preset_")
        self.isCustom = try container.decodeIfPresent(Bool.self, forKey: .isCustom) ?? defaultIsCustom
        self.isVisible = try container.decodeIfPresent(Bool.self, forKey: .isVisible) ?? true
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(icon, forKey: .icon)
        try container.encode(colorHex, forKey: .colorHex)
        try container.encode(uri, forKey: .uri)
        try container.encodeIfPresent(logoURL, forKey: .logoURL)
        try container.encode(isCustom, forKey: .isCustom)
        try container.encode(isVisible, forKey: .isVisible)
    }
}

// MARK: - Preset Catalogue

extension AppShortcut {
    public static let catalogue: [AppShortcut] = [
        AppShortcut(id: "preset_youtube",    name: "YouTube",      icon: "play.rectangle.fill", colorHex: "#FF0000", uri: "https://www.youtube.com",                logoURL: "https://www.google.com/s2/favicons?domain=youtube.com&sz=64",         isCustom: false, isVisible: true),
        AppShortcut(id: "preset_netflix",    name: "Netflix",      icon: "film.fill",           colorHex: "#E50914", uri: "https://www.netflix.com",                logoURL: "https://www.google.com/s2/favicons?domain=netflix.com&sz=64",         isCustom: false, isVisible: true),
        AppShortcut(id: "preset_disney",     name: "Disney+",      icon: "sparkles.tv.fill",    colorHex: "#0063E5", uri: "https://www.disneyplus.com",             logoURL: "https://www.google.com/s2/favicons?domain=disneyplus.com&sz=64",     isCustom: false, isVisible: true),
        AppShortcut(id: "preset_appletv",    name: "Apple TV",     icon: "tv.fill",             colorHex: "#000000", uri: "https://tv.apple.com",                   logoURL: "https://www.google.com/s2/favicons?domain=apple.com&sz=64",          isCustom: false, isVisible: false),
        AppShortcut(id: "preset_prime",      name: "Prime Video",  icon: "tv.fill",             colorHex: "#00A8E1", uri: "https://app.primevideo.com",             logoURL: "https://www.google.com/s2/favicons?domain=primevideo.com&sz=64",     isCustom: false, isVisible: false),
        AppShortcut(id: "preset_coupang",    name: "Coupang Play", icon: "cart.fill",           colorHex: "#EE2222", uri: "https://www.coupangplay.com",            logoURL: "https://www.google.com/s2/favicons?domain=coupangplay.com&sz=64",    isCustom: false, isVisible: false),
        AppShortcut(id: "preset_max",        name: "Max",          icon: "play.tv.fill",        colorHex: "#002BE7", uri: "https://play.hbomax.com",                logoURL: "https://www.google.com/s2/favicons?domain=max.com&sz=64",             isCustom: false, isVisible: false),
        AppShortcut(id: "preset_paramount",  name: "Paramount+",   icon: "mountain.2.fill",     colorHex: "#0064FF", uri: "https://www.paramountplus.com/",         logoURL: "https://www.google.com/s2/favicons?domain=paramountplus.com&sz=64",  isCustom: false, isVisible: false),
        AppShortcut(id: "preset_youtubetv",  name: "YouTube TV",   icon: "play.tv.fill",        colorHex: "#FF0000", uri: "https://tv.youtube.com",                logoURL: "https://www.google.com/s2/favicons?domain=tv.youtube.com&sz=64",     isCustom: false, isVisible: false),
        AppShortcut(id: "preset_tubi",       name: "Tubi",         icon: "play.circle.fill",    colorHex: "#FA3200", uri: "https://tubitv.com/",                    logoURL: "https://www.google.com/s2/favicons?domain=tubitv.com&sz=64",         isCustom: false, isVisible: false),
        AppShortcut(id: "preset_plutotv",    name: "Pluto TV",     icon: "tv.circle.fill",      colorHex: "#FDD835", uri: "https://pluto.tv/en/live-tv",            logoURL: "https://www.google.com/s2/favicons?domain=pluto.tv&sz=64",           isCustom: false, isVisible: false),
        AppShortcut(id: "preset_playstore",  name: "Google Play",  icon: "bag.fill",            colorHex: "#01875F", uri: "https://play.google.com/store/",         logoURL: "https://www.google.com/s2/favicons?domain=play.google.com&sz=64",    isCustom: false, isVisible: false),
        AppShortcut(id: "preset_surfshark",  name: "Surfshark",    icon: "shield.fill",         colorHex: "#1CA390", uri: "https://surfshark.com/locations-ul",     logoURL: "https://www.google.com/s2/favicons?domain=surfshark.com&sz=64",      isCustom: false, isVisible: false),
        AppShortcut(id: "preset_plex",       name: "Plex",         icon: "play.rectangle.fill", colorHex: "#E5A00D", uri: "plex://",                               logoURL: "https://www.google.com/s2/favicons?domain=plex.tv&sz=64",           isCustom: false, isVisible: false),
        AppShortcut(id: "preset_spotify",    name: "Spotify",      icon: "music.note",          colorHex: "#1DB954", uri: "spotify://",                            logoURL: "https://www.google.com/s2/favicons?domain=spotify.com&sz=64",        isCustom: false, isVisible: false),
        AppShortcut(id: "preset_twitch",     name: "Twitch",       icon: "gamecontroller.fill", colorHex: "#9146FF", uri: "twitch://home",                        logoURL: "https://www.google.com/s2/favicons?domain=twitch.tv&sz=64",          isCustom: false, isVisible: false),
        AppShortcut(id: "preset_stremio",    name: "Stremio",      icon: "film.stack.fill",     colorHex: "#5E35B1", uri: "stremio:///",                            logoURL: "https://www.google.com/s2/favicons?domain=stremio.com&sz=64",         isCustom: false, isVisible: false),
    ]
}

// MARK: - Store

@MainActor
public final class AppShortcutStore: ObservableObject {
    public static let shared = AppShortcutStore()

    @Published public var items: [AppShortcut] {
        didSet { save() }
    }

    /// Visible items displayed in main remote
    public var selected: [AppShortcut] {
        items.filter { $0.isVisible }
    }

    public var visibleItems: [AppShortcut] {
        items.filter { $0.isVisible }
    }

    private let storeKey = "gtv_app_shortcuts_v3"

    private init() {
        if let saved: [AppShortcut] = Self.load(key: storeKey), !saved.isEmpty {
            var updated: [AppShortcut] = []
            for item in saved {
                if item.name == "웨이브" || item.name == "티빙" { continue }
                if let cat = AppShortcut.catalogue.first(where: { $0.id == item.id }) {
                    var m = cat
                    m.isVisible = item.isVisible
                    updated.append(m)
                } else {
                    updated.append(item)
                }
            }
            // Append any newly added catalogue items not yet in store
            for cat in AppShortcut.catalogue {
                if !updated.contains(where: { $0.id == cat.id }) {
                    var m = cat
                    m.isVisible = false
                    updated.append(m)
                }
            }
            items = updated
        } else {
            // Migration from legacy schema (selected / custom)
            let savedSelected: [AppShortcut]? = Self.load(key: "gtv_selected_shortcuts")
            let savedCustom: [AppShortcut]? = Self.load(key: "gtv_custom_shortcuts")

            var merged: [AppShortcut] = []
            let selectedIDs = Set((savedSelected ?? []).map { $0.id })

            if savedSelected != nil || savedCustom != nil {
                for sel in savedSelected ?? [] {
                    if sel.name == "웨이브" || sel.name == "티빙" { continue }
                    if let cat = AppShortcut.catalogue.first(where: { $0.id == sel.id || $0.name == sel.name }) {
                        var m = cat
                        m.isVisible = true
                        merged.append(m)
                    } else {
                        var customItem = sel
                        customItem.isCustom = true
                        customItem.isVisible = true
                        merged.append(customItem)
                    }
                }
                for cat in AppShortcut.catalogue {
                    if !merged.contains(where: { $0.id == cat.id }) {
                        var m = cat
                        m.isVisible = selectedIDs.contains(cat.id)
                        merged.append(m)
                    }
                }
                for c in savedCustom ?? [] {
                    if !merged.contains(where: { $0.id == c.id }) {
                        var customItem = c
                        customItem.isCustom = true
                        customItem.isVisible = selectedIDs.contains(c.id)
                        merged.append(customItem)
                    }
                }
                items = merged.isEmpty ? AppShortcut.catalogue : merged
            } else {
                items = AppShortcut.catalogue
            }
        }
    }

    // MARK: - Actions

    public func move(fromOffsets offsets: IndexSet, toOffset destination: Int) {
        items.move(fromOffsets: offsets, toOffset: destination)
    }

    public func toggleVisibility(id: String) {
        guard let index = items.firstIndex(where: { $0.id == id }) else { return }
        items[index].isVisible.toggle()
    }

    public func setVisibility(id: String, isVisible: Bool) {
        guard let index = items.firstIndex(where: { $0.id == id }) else { return }
        items[index].isVisible = isVisible
    }

    public func addCustom(name: String, uri: String) {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !uri.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        let newApp = AppShortcut(
            name: name.trimmingCharacters(in: .whitespaces),
            icon: "app.fill",
            colorHex: "#888888",
            uri: uri.trimmingCharacters(in: .whitespaces),
            isCustom: true,
            isVisible: true
        )
        items.append(newApp)
    }

    public func updateCustom(id: String, name: String, uri: String) {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !uri.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        guard let index = items.firstIndex(where: { $0.id == id }) else { return }
        items[index].name = name.trimmingCharacters(in: .whitespaces)
        items[index].uri = uri.trimmingCharacters(in: .whitespaces)
    }

    public func deleteCustom(id: String) {
        items.removeAll { $0.id == id && $0.isCustom }
    }

    private func save() {
        if let d = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(d, forKey: storeKey)
        }
    }

    private static func load<T: Decodable>(key: String) -> T? {
        guard let d = UserDefaults.standard.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(T.self, from: d)
    }
}

// MARK: - Color Hex Helper

extension Color {
    init?(hex: String) {
        var s = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if s.hasPrefix("#") { s = String(s.dropFirst()) }
        guard s.count == 6, let v = UInt64(s, radix: 16) else { return nil }
        self.init(
            red:   Double((v >> 16) & 0xFF) / 255,
            green: Double((v >>  8) & 0xFF) / 255,
            blue:  Double( v        & 0xFF) / 255
        )
    }
}
