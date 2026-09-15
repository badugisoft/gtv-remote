import SwiftUI

public struct PairingSheetView: View {
    @ObservedObject var viewModel: RemoteViewModel
    @ObservedObject private var loc = LocalizationManager.shared
    @FocusState private var isPinFocused: Bool
    
    public init(viewModel: RemoteViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "lock.shield.fill")
                .font(.system(size: 36))
                .foregroundColor(.blue)
            
            Text(L10n.pairingTitle)
                .font(.headline)
            
            Text(L10n.pairingPrompt)
                .font(.system(size: 12))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            TextField("PIN (e.g. 1A2B3C)", text: $viewModel.pairingPinCode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.system(size: 16, weight: .bold, design: .monospaced))
                .multilineTextAlignment(.center)
                .focused($isPinFocused)
                .frame(width: 180)
                .onChange(of: viewModel.pairingPinCode) { _, newValue in
                    // Only allow hex characters (0-9, A-F), automatically capitalized
                    let filtered = newValue.uppercased().filter { $0.isHexDigit }
                    if filtered != newValue { viewModel.pairingPinCode = filtered }
                }
                .onSubmit {
                    viewModel.submitPinCode()
                }
            
            HStack(spacing: 12) {
                Button(L10n.cancel) {
                    viewModel.isPairingSheetPresented = false
                }
                
                Button(L10n.pair) {
                    viewModel.submitPinCode()
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .disabled(viewModel.pairingPinCode.trimmingCharacters(in: .whitespaces).isEmpty)
            }
        }
        .padding(24)
        .frame(width: 300)
        .onAppear {
            isPinFocused = true
        }
    }
}
