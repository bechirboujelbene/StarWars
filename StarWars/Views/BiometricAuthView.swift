import SwiftUI
import LocalAuthentication

struct BiometricAuthView: View {
    @EnvironmentObject var authService: AuthenticationService
    @State private var biometryType: LABiometryType = .none

    var body: some View {
        VStack(spacing: 30) {
            Spacer()

            
            Image(systemName: biometryIconName)
                .font(.system(size: 80))
                .foregroundColor(.blue)

            Text("Authentication Required")
                .font(.title)
                .fontWeight(.semibold)

            Text("Use \(biometryTypeName) or Passcode")
                 .font(.body)
                 .foregroundColor(.secondary)
                 .multilineTextAlignment(.center)
                 .padding(.horizontal)

            // Display error message if authentication failed previously
            if let errorMessage = authService.authenticationError, !authService.requiresPINEntry {
                 Text(errorMessage)
                     .foregroundColor(.red)
                     .font(.caption)
                     .multilineTextAlignment(.center)
                     .padding(.horizontal)
             }

            // Button to trigger authentication
            Button {
                authService.authenticateWithBiometrics()
            } label: {
                 Label("Authenticate", systemImage: "lock.shield.fill") // Generic lock
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 40)
             
             // Button to go directly to PIN entry
             Button("Enter PIN Instead") {
                 authService.requestPINEntry()
             }
             .font(.footnote)
             .padding(.top, 10)


            Spacer()
            Spacer()
        }
        .padding()
        .onAppear {
             // Check biometry type when view appears
             checkBiometryType()
             
             if !authService.isAuthenticated && !authService.requiresPINEntry {
                 DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                     if !authService.isAuthenticated && !authService.requiresPINEntry {
                         authService.authenticateWithBiometrics()
                     }
                 }
             }
        }
    }

    // Helper function to check biometry type for UI customization
    private func checkBiometryType() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            biometryType = context.biometryType
        } else {
             biometryType = .none 
        }
    }

    // Computed property for the icon name
    private var biometryIconName: String {
        switch biometryType {
        case .faceID:
            return "faceid"
        case .touchID:
            return "touchid"
        default:
            return "lock.fill" // Fallback icon
        }
    }
    
    // Computed property for the biometry type name
    private var biometryTypeName: String {
         switch biometryType {
         case .faceID:
             return "Face ID"
         case .touchID:
             return "Touch ID"
         default:
             return "Device Authentication" // Fallback name
         }
     }
}

struct BiometricAuthView_Previews: PreviewProvider {
    static var previews: some View {
        BiometricAuthView()
            .environmentObject(AuthenticationService()) // Provide a dummy service
    }
}
