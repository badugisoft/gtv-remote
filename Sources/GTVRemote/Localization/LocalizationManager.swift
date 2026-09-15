import Foundation
import SwiftUI

/// Supported interface languages
public enum AppLanguage: String, CaseIterable, Identifiable, Sendable {
    case en = "en"
    case ko = "ko"
    case zhHans = "zh-Hans"
    case ja = "ja"
    case de = "de"
    case fr = "fr"
    case es = "es"

    public var id: String { rawValue }

    public var displayName: String {
        switch self {
        case .en:     return "English"
        case .ko:     return "한국어"
        case .zhHans: return "简体中文"
        case .ja:     return "日本語"
        case .de:     return "Deutsch"
        case .fr:     return "Français"
        case .es:     return "Español"
        }
    }
}

/// Global observable localization manager
@MainActor
public final class LocalizationManager: ObservableObject {
    public static let shared = LocalizationManager()

    private let languageKey = "gtv_app_language_v1"

    @Published public var currentLanguage: AppLanguage {
        didSet {
            UserDefaults.standard.set(currentLanguage.rawValue, forKey: languageKey)
        }
    }

    /// Active localized strings bundle for the selected language
    public var strings: LocalizableStrings {
        switch currentLanguage {
        case .en:     return EnglishStrings()
        case .ko:     return KoreanStrings()
        case .zhHans: return ChineseStrings()
        case .ja:     return JapaneseStrings()
        case .de:     return GermanStrings()
        case .fr:     return FrenchStrings()
        case .es:     return SpanishStrings()
        }
    }

    private init() {
        if let saved = UserDefaults.standard.string(forKey: languageKey),
           let lang = AppLanguage(rawValue: saved) {
            self.currentLanguage = lang
        } else {
            // Automatically detect system language preference
            let preferred = Locale.preferredLanguages.first ?? "en"
            if preferred.hasPrefix("ko") {
                self.currentLanguage = .ko
            } else if preferred.hasPrefix("zh") {
                self.currentLanguage = .zhHans
            } else if preferred.hasPrefix("ja") {
                self.currentLanguage = .ja
            } else if preferred.hasPrefix("de") {
                self.currentLanguage = .de
            } else if preferred.hasPrefix("fr") {
                self.currentLanguage = .fr
            } else if preferred.hasPrefix("es") {
                self.currentLanguage = .es
            } else {
                self.currentLanguage = .en
            }
        }
    }

    public func setLanguage(_ language: AppLanguage) {
        self.currentLanguage = language
    }
}
