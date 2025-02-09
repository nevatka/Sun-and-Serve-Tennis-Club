import SwiftUI

@MainActor
final class RegisterViewViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var name: String = ""
    @Published var lastName: String = ""
    
    func signIn() async throws{
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        
        _ = try await AuthenticationManager.shared.createUser(email: email, password: password)
    }
}
