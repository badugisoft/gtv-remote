import SwiftUI
import AppKit

// MARK: - Remote Icon Button Style (Power, Play, Volume, Navigation)

public struct RemoteIconButtonStyle: ButtonStyle {
    public var baseColor: Color
    public var hoverColor: Color? = nil
    public var foregroundColor: Color = .primary.opacity(0.8)
    public var hoverForegroundColor: Color = .primary
    public var cornerRadius: CGFloat = 8
    public var isExternalPressed: Bool = false

    @State private var isHovered = false

    public init(
        baseColor: Color,
        hoverColor: Color? = nil,
        foregroundColor: Color = .primary.opacity(0.8),
        hoverForegroundColor: Color = .primary,
        cornerRadius: CGFloat = 8,
        isExternalPressed: Bool = false
    ) {
        self.baseColor = baseColor
        self.hoverColor = hoverColor
        self.foregroundColor = foregroundColor
        self.hoverForegroundColor = hoverForegroundColor
        self.cornerRadius = cornerRadius
        self.isExternalPressed = isExternalPressed
    }

    public func makeBody(configuration: Configuration) -> some View {
        let isPressed = configuration.isPressed || isExternalPressed
        let bg = isPressed
            ? (hoverColor ?? baseColor).opacity(1.3)
            : (isHovered ? (hoverColor ?? Color.primary.opacity(0.12)) : baseColor)

        configuration.label
            .foregroundColor(isHovered ? hoverForegroundColor : foregroundColor)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(bg)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(
                                isPressed
                                    ? Color.blue.opacity(0.5)
                                    : Color.primary.opacity(isHovered ? 0.14 : 0.0),
                                lineWidth: isPressed ? 1.5 : 1
                            )
                    )
            )
            .scaleEffect(isPressed ? 0.94 : (isHovered ? 1.03 : 1.0))
            .animation(.easeInOut(duration: 0.15), value: isHovered)
            .animation(.easeInOut(duration: 0.08), value: isPressed)
            .onHover { hovering in
                isHovered = hovering
            }
    }
}

// MARK: - App Tile Button Style (Quick App Tiles)

public struct AppTileButtonStyle: ButtonStyle {
    @State private var isHovered = false

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        let isPressed = configuration.isPressed
        configuration.label
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.primary.opacity(isPressed ? 0.15 : (isHovered ? 0.11 : 0.05)))
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.primary.opacity(isHovered ? 0.16 : 0.04), lineWidth: 1)
                    )
            )
            .scaleEffect(isPressed ? 0.94 : (isHovered ? 1.04 : 1.0))
            .shadow(color: Color.black.opacity(isHovered ? 0.08 : 0.0), radius: 3, x: 0, y: 1.5)
            .animation(.easeInOut(duration: 0.15), value: isHovered)
            .animation(.easeInOut(duration: 0.08), value: isPressed)
            .onHover { hovering in
                isHovered = hovering
            }
    }
}

// MARK: - D-Pad Arrow Button Style (Up / Down / Left / Right)

public struct DPadArrowButtonStyle: ButtonStyle {
    public var isExternalPressed: Bool = false
    @State private var isHovered = false

    public init(isExternalPressed: Bool = false) {
        self.isExternalPressed = isExternalPressed
    }

    public func makeBody(configuration: Configuration) -> some View {
        let isPressed = configuration.isPressed || isExternalPressed
        configuration.label
            .foregroundColor(isHovered || isPressed ? .primary : .primary.opacity(0.75))
            .background(
                Circle()
                    .fill(Color.primary.opacity(isPressed ? 0.22 : (isHovered ? 0.09 : 0.0)))
                    .overlay(
                        Circle()
                            .stroke(isPressed ? Color.blue.opacity(0.4) : Color.clear, lineWidth: 1.5)
                    )
                    .frame(width: 38, height: 38)
            )
            .scaleEffect(isPressed ? 0.88 : (isHovered ? 1.14 : 1.0))
            .animation(.easeInOut(duration: 0.12), value: isHovered)
            .animation(.easeInOut(duration: 0.06), value: isPressed)
            .onHover { hovering in
                isHovered = hovering
            }
    }
}

// MARK: - D-Pad Center OK Button Style

public struct DPadCenterButtonStyle: ButtonStyle {
    public var isExternalPressed: Bool = false
    @State private var isHovered = false

    public init(isExternalPressed: Bool = false) {
        self.isExternalPressed = isExternalPressed
    }

    public func makeBody(configuration: Configuration) -> some View {
        let isPressed = configuration.isPressed || isExternalPressed
        configuration.label
            .scaleEffect(isPressed ? 0.90 : (isHovered ? 1.05 : 1.0))
            .shadow(
                color: Color.blue.opacity(isPressed ? 0.6 : (isHovered ? 0.5 : 0.3)),
                radius: isPressed ? 12 : (isHovered ? 10 : 6),
                x: 0,
                y: isPressed ? 2 : (isHovered ? 4 : 3)
            )
            .overlay(
                Circle()
                    .stroke(
                        isPressed
                            ? Color.white.opacity(0.8)
                            : Color.white.opacity(isHovered ? 0.35 : 0.1),
                        lineWidth: isPressed ? 2.5 : 1.5
                    )
            )
            .animation(.easeInOut(duration: 0.15), value: isHovered)
            .animation(.easeInOut(duration: 0.08), value: isPressed)
            .onHover { hovering in
                isHovered = hovering
            }
    }
}

// MARK: - Header Device Button Style

public struct HeaderDeviceButtonStyle: ButtonStyle {
    @State private var isHovered = false

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        let isPressed = configuration.isPressed
        configuration.label
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.primary.opacity(isPressed ? 0.12 : (isHovered ? 0.09 : 0.05)))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.primary.opacity(isHovered ? 0.12 : 0.0), lineWidth: 1)
                    )
            )
            .scaleEffect(isPressed ? 0.98 : (isHovered ? 1.01 : 1.0))
            .animation(.easeInOut(duration: 0.15), value: isHovered)
            .animation(.easeInOut(duration: 0.08), value: isPressed)
            .onHover { hovering in
                isHovered = hovering
            }
    }
}

// MARK: - Header Icon Button Style (Shortcuts, Settings Gear, Language)

public struct HeaderIconButtonStyle: ButtonStyle {
    public var cornerRadius: CGFloat = 8
    @State private var isHovered = false

    public init(cornerRadius: CGFloat = 8) {
        self.cornerRadius = cornerRadius
    }

    public func makeBody(configuration: Configuration) -> some View {
        let isPressed = configuration.isPressed
        configuration.label
            .foregroundColor(isHovered ? .primary : .secondary)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.primary.opacity(isPressed ? 0.12 : (isHovered ? 0.09 : 0.05)))
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(Color.primary.opacity(isHovered ? 0.12 : 0.0), lineWidth: 1)
                    )
            )
            .scaleEffect(isPressed ? 0.92 : (isHovered ? 1.06 : 1.0))
            .animation(.easeInOut(duration: 0.15), value: isHovered)
            .animation(.easeInOut(duration: 0.08), value: isPressed)
            .onHover { hovering in
                isHovered = hovering
            }
    }
}

// MARK: - SmartBar Icon Button Style (Clipboard, Input Send)

public struct SmartBarIconButtonStyle: ButtonStyle {
    public var foregroundColor: Color
    public var hoverForegroundColor: Color
    @State private var isHovered = false

    public init(foregroundColor: Color = .secondary, hoverForegroundColor: Color = .primary) {
        self.foregroundColor = foregroundColor
        self.hoverForegroundColor = hoverForegroundColor
    }

    public func makeBody(configuration: Configuration) -> some View {
        let isPressed = configuration.isPressed
        configuration.label
            .foregroundColor(isHovered ? hoverForegroundColor : foregroundColor)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.primary.opacity(isPressed ? 0.12 : (isHovered ? 0.08 : 0.0)))
            )
            .scaleEffect(isPressed ? 0.9 : (isHovered ? 1.08 : 1.0))
            .animation(.easeInOut(duration: 0.15), value: isHovered)
            .animation(.easeInOut(duration: 0.08), value: isPressed)
            .onHover { hovering in
                isHovered = hovering
            }
    }
}
