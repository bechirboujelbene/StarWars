import SwiftUI

struct PINEntryView: View {
    @EnvironmentObject var authService: AuthenticationService
    @State private var enteredPIN: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            Image(systemName: "key.fill")
                .font(.system(size: 60))
                .foregroundColor(.blue)
                .padding(.bottom, 20)

            Text("Enter Your PIN")
                .font(.title2)
                .fontWeight(.semibold)

            Text("Please enter your PIN to continue.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            SecureField("PIN", text: $enteredPIN)
                .keyboardType(.numberPad)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .font(.title3)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 200)
                .padding(.vertical)

            if let errorMessage = authService.authenticationError {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }

            Button {
                authService.attemptLoginWithPIN(enteredPIN)
            } label: {
                Label("Login", systemImage: "arrow.right.circle.fill")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 40)
            .disabled(enteredPIN.isEmpty)

            Spacer()
            Spacer()
        }
        .padding()
        .onAppear {
            if authService.authenticationError == "Authentication failed. Please enter your PIN." {
                authService.authenticationError = nil
            }
        }
    }
}

struct PINEntryView_Previews: PreviewProvider {
    static var previews: some View {
        let previewAuthService = AuthenticationService()
        

        return PINEntryView()
            .environmentObject(previewAuthService)
    }
}
