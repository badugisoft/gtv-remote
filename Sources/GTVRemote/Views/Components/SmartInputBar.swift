import SwiftUI

public struct SmartInputBar: View {
    @ObservedObject var viewModel: RemoteViewModel
    @ObservedObject private var loc = LocalizationManager.shared
    @FocusState private var isInputFocused: Bool
    
    public init(viewModel: RemoteViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 8) {
                Image(systemName: "keyboard")
                    .foregroundColor(.secondary)
                    .font(.system(size: 13))
                
                TextField(L10n.inputPlaceholder, text: $viewModel.inputText)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(.system(size: 13))
                    .focused($isInputFocused)
                    .onSubmit {
                        viewModel.sendText(viewModel.inputText)
                    }
                
                if !viewModel.inputText.isEmpty {
                    Button(action: {
                        viewModel.sendText(viewModel.inputText)
                    }) {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.system(size: 16))
                            .frame(width: 22, height: 22)
                    }
                    .buttonStyle(SmartBarIconButtonStyle(foregroundColor: .blue, hoverForegroundColor: .blue.opacity(0.8)))
                    .help(L10n.send)
                }
                
                // Send clipboard content
                Button(action: {
                    viewModel.sendClipboardText()
                }) {
                    Image(systemName: "doc.on.clipboard")
                        .font(.system(size: 12))
                        .frame(width: 22, height: 22)
                }
                .buttonStyle(SmartBarIconButtonStyle())
                .help("Send clipboard content")
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 7)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(nsColor: .textBackgroundColor).opacity(0.6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isInputFocused ? Color.blue.opacity(0.5) : Color.primary.opacity(0.08), lineWidth: 1)
                    )
            )
        }
        .onChange(of: viewModel.isIMEActive) { _, active in
            if active {
                isInputFocused = true
            }
        }
    }
}
