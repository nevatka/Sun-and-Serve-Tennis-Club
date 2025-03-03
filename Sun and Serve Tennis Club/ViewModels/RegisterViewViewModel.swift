import SwiftUI

@MainActor
final class RegisterViewViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var name: String = ""
    @Published var lastName: String = ""
    
    private var authManager: AuthenticationManager

    init(
        authManager: AuthenticationManager = .shared
    ) {
        self.authManager = authManager
    }
    
    func signIn() async throws{
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        
        _ = try await authManager.createUser(email: email, password: password)
    }
}
