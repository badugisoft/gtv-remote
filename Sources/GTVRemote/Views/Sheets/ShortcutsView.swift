import SwiftUI

/// Sheet presenting keyboard shortcuts reference
struct ShortcutsView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var loc = LocalizationManager.shared

    private struct ShortcutItem: Identifiable {
        let id = UUID()
        let key: String
        let description: String
    }

    private struct ShortcutGroup: Identifiable {
        let id = UUID()
        let title: String
        let items: [ShortcutItem]
    }

    private var groups: [ShortcutGroup] {
        [
            ShortcutGroup(
                title: L10n.groupNav,
                items: [
                    ShortcutItem(key: L10n.keyArrow, description: L10n.descArrow),
                    ShortcutItem(key: L10n.keyEnter, description: L10n.descEnter),
                    ShortcutItem(key: L10n.keyEsc, description: L10n.descEsc),
                    ShortcutItem(key: L10n.keyH, description: L10n.descH)
                ]
            ),
            ShortcutGroup(
                title: L10n.groupMedia,
                items: [
                    ShortcutItem(key: L10n.keySpace, description: L10n.descSpace),
                    ShortcutItem(key: L10n.keyVolume, description: L10n.descVolume),
                    ShortcutItem(key: L10n.keyM, description: L10n.descM)
                ]
            ),
            ShortcutGroup(
                title: L10n.groupSystem,
                items: [
                    ShortcutItem(key: L10n.keyP, description: L10n.descP),
                    ShortcutItem(key: L10n.keyA, description: L10n.descA),
                    ShortcutItem(key: L10n.keyI, description: L10n.descI),
                    ShortcutItem(key: L10n.keyNumbers, description: L10n.descNumbers),
                    ShortcutItem(key: "Cmd + V", description: "Send clipboard text")
                ]
            )
        ]
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header
            HStack {
                Text(L10n.shortcutsTitle)
                    .font(.headline)
                Spacer()
                Button(L10n.done) { dismiss() }
                    .keyboardShortcut(.defaultAction)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)

            Divider()

            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    Text(L10n.shortcutsDesc)
                        .font(.system(size: 11))
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 16)
                        .padding(.top, 4)

                    ForEach(groups) { group in
                        VStack(alignment: .leading, spacing: 6) {
                            Text(group.title)
                                .font(.system(size: 11, weight: .semibold))
                                .foregroundColor(.secondary)
                                .padding(.horizontal, 16)

                            VStack(spacing: 0) {
                                ForEach(Array(group.items.enumerated()), id: \.element.id) { index, item in
                                    HStack {
                                        Text(item.description)
                                            .font(.system(size: 12))
                                            .frame(maxWidth: .infinity, alignment: .leading)

                                        Text(item.key)
                                            .font(.system(size: 11, weight: .medium, design: .monospaced))
                                            .foregroundColor(.secondary)
                                            .padding(.horizontal, 6)
                                            .padding(.vertical, 2)
                                            .background(Color.primary.opacity(0.06))
                                            .cornerRadius(4)
                                    }
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)

                                    if index < group.items.count - 1 {
                                        Divider().padding(.leading, 12)
                                    }
                                }
                            }
                            .background(Color.primary.opacity(0.04))
                            .cornerRadius(8)
                            .padding(.horizontal, 16)
                        }
                    }
                }
                .padding(.vertical, 12)
            }
        }
        .frame(width: 340, height: 480)
    }
}
