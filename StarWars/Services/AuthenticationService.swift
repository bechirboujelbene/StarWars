import Foundation
import Combine
import LocalAuthentication

class AuthenticationService: ObservableObject {
    @Published var isAuthenticated = false
    @Published var authenticationError: String?
    @Published var requiresPINEntry = false

    private let correctPIN = "1234"

    init() {
        self.isAuthenticated = false
        self.requiresPINEntry = false
        self.authenticationError = nil
    }

    func authenticateWithBiometrics() {
        self.authenticationError = nil
        self.requiresPINEntry = false

        let context = LAContext()
        var error: NSError?
        let reason = "Authenticate to access the Star Wars Universe."

        // Check if BIOMETRIC authentication is possible
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            // If not possible go straight to PIN entry
            DispatchQueue.main.async {
                self.authenticationError = "Biometric authentication not available. Please enter PIN."
                self.requiresPINEntry = true
                self.isAuthenticated = false
            }
            return
        }

        // Attempt BIOMETRIC authentication 
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
            DispatchQueue.main.async {
                if success {
                    self.isAuthenticated = true
                    self.authenticationError = nil
                    self.requiresPINEntry = false
                } else {
                    self.isAuthenticated = false
                    self.authenticationError = "Authentication failed. Please enter your PIN."
                    self.requiresPINEntry = true
                }
            }
        }
    }

    func attemptLoginWithPIN(_ pin: String) {
        DispatchQueue.main.async {
            if pin == self.correctPIN {
                self.isAuthenticated = true
                self.authenticationError = nil
                self.requiresPINEntry = false
            } else {
                self.isAuthenticated = false
                self.authenticationError = "Incorrect PIN"
                self.requiresPINEntry = true
            }
        }
    }

    func requestPINEntry() {
        DispatchQueue.main.async {
            self.isAuthenticated = false
            self.authenticationError = "Please enter your PIN."
            self.requiresPINEntry = true
        }
    }

    func logout() {
        DispatchQueue.main.async {
            self.isAuthenticated = false
            self.authenticationError = nil
            self.requiresPINEntry = false
        }
    }

    deinit {
    }
}
