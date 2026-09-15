import SwiftUI

/// Sheet for managing quick app shortcuts, ordering, and custom links
struct AppShortcutsSettingsView: View {
    @ObservedObject var store = AppShortcutStore.shared
    @ObservedObject private var loc = LocalizationManager.shared
    @Environment(\.dismiss) private var dismiss

    // Add app form states
    @State private var showAddForm: Bool = false
    @State private var newName: String = ""
    @State private var newURI: String = ""

    // Edit app modal states
    @State private var editingApp: AppShortcut?
    @State private var editName: String = ""
    @State private var editURI: String = ""

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text(L10n.settingsTitle)
                    .font(.headline)
                Spacer()
                Button(L10n.done) { dismiss() }
                    .keyboardShortcut(.defaultAction)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)

            Divider()

            // Unified App List with drag-and-drop reordering
            List {
                Section {
                    ForEach(store.items) { app in
                        shortcutRow(for: app)
                            .listRowInsets(EdgeInsets(top: 4, leading: 10, bottom: 4, trailing: 10))
                    }
                    .onMove { indices, newOffset in
                        store.move(fromOffsets: indices, toOffset: newOffset)
                    }
                } header: {
                    HStack {
                        Text(L10n.listVisibleCount(visible: store.visibleItems.count, total: store.items.count))
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(L10n.dragToReorder)
                            .font(.system(size: 10))
                            .foregroundColor(.secondary)
                    }
                    .padding(.bottom, 2)
                }
            }
            .listStyle(InsetListStyle())

            Divider()

            // Bottom: Add custom app section
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(L10n.addCustomApp)
                        .font(.system(size: 12, weight: .semibold))
                    Spacer()
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            showAddForm.toggle()
                        }
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: showAddForm ? "chevron.up" : "plus")
                            Text(showAddForm ? L10n.collapse : L10n.addCustomApp)
                        }
                        .font(.system(size: 11))
                    }
                    .buttonStyle(.plain)
                    .foregroundColor(.accentColor)
                }

                if showAddForm {
                    VStack(spacing: 6) {
                        TextField(L10n.appNamePlaceholder, text: $newName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .font(.system(size: 12))

                        TextField(L10n.uriPlaceholder, text: $newURI)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .font(.system(size: 12))

                        HStack {
                            Spacer()
                            Button(L10n.add) {
                                store.addCustom(name: newName, uri: newURI)
                                newName = ""
                                newURI = ""
                                withAnimation { showAddForm = false }
                            }
                            .buttonStyle(.borderedProminent)
                            .controlSize(.small)
                            .disabled(newName.trimmingCharacters(in: .whitespaces).isEmpty ||
                                      newURI.trimmingCharacters(in: .whitespaces).isEmpty)
                        }
                    }
                    .padding(8)
                    .background(Color.primary.opacity(0.04))
                    .cornerRadius(6)
                }
            }
            .padding(12)
            .background(Color(NSColor.windowBackgroundColor))
        }
        .frame(width: 340, height: 460)
        // Edit custom app sheet
        .sheet(item: $editingApp) { app in
            VStack(alignment: .leading, spacing: 14) {
                Text(L10n.editAppShortcut)
                    .font(.headline)

                VStack(alignment: .leading, spacing: 4) {
                    Text(L10n.appName)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    TextField(L10n.appName, text: $editName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(L10n.deepLinkURI)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    TextField(L10n.deepLinkURI, text: $editURI)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                HStack {
                    Button(L10n.cancel) { editingApp = nil }
                    Spacer()
                    Button(L10n.save) {
                        store.updateCustom(id: app.id, name: editName, uri: editURI)
                        editingApp = nil
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(editName.trimmingCharacters(in: .whitespaces).isEmpty ||
                              editURI.trimmingCharacters(in: .whitespaces).isEmpty)
                }
                .padding(.top, 6)
            }
            .padding(20)
            .frame(width: 280)
        }
    }

    // MARK: - Row View

    @ViewBuilder
    private func shortcutRow(for app: AppShortcut) -> some View {
        HStack(spacing: 8) {
            // Visibility checkbox
            Button(action: {
                store.toggleVisibility(id: app.id)
            }) {
                Image(systemName: app.isVisible ? "checkmark.square.fill" : "square")
                    .foregroundColor(app.isVisible ? .accentColor : .secondary.opacity(0.6))
                    .font(.system(size: 15))
            }
            .buttonStyle(.plain)

            // App representation
            if app.isCustom {
                VStack(alignment: .leading, spacing: 2) {
                    Text(app.name)
                        .font(.system(size: 12, weight: .medium))
                    Text(app.uri)
                        .font(.system(size: 10))
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                AppLogoView(app: app)
                    .frame(width: 18, height: 18)

                Text(app.name)
                    .font(.system(size: 12, weight: .medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            // Edit and delete buttons for custom apps only
            if app.isCustom {
                Button(action: {
                    editingApp = app
                    editName = app.name
                    editURI = app.uri
                }) {
                    Image(systemName: "pencil")
                        .font(.system(size: 11))
                        .foregroundColor(.secondary)
                        .frame(width: 20, height: 20)
                }
                .buttonStyle(.plain)
                .help(L10n.edit)

                Button(action: {
                    withAnimation {
                        store.deleteCustom(id: app.id)
                    }
                }) {
                    Image(systemName: "trash")
                        .font(.system(size: 11))
                        .foregroundColor(.red.opacity(0.8))
                        .frame(width: 20, height: 20)
                }
                .buttonStyle(.plain)
                .help(L10n.delete)
            }

            // Visual drag handle hint
            Image(systemName: "line.3.horizontal")
                .font(.system(size: 11))
                .foregroundColor(.secondary.opacity(0.4))
                .frame(width: 16)
        }
        .padding(.vertical, 4)
    }
}
