import SwiftUI

@MainActor
final class RegisterViewViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var name: String = ""
    @Published var lastName: String = ""
    @Published var wrongEmail: Bool = false
    @Published var wrongPassword: Bool = false
    
    private var authManager: AuthenticationManager
    private var formValidation: FormValidation
    private var membersCollector: MembersCollector

    init(
        authManager: AuthenticationManager = .shared,
        formValidation: FormValidation = FormValidation(),
        membersCollector: MembersCollector = MembersCollector()
    ) {
        self.authManager = authManager
        self.formValidation = formValidation
        self.membersCollector = membersCollector
    }
    
    func signIn() async throws{
        guard !email.isEmpty, !password.isEmpty else {
            return
        }
        let isEmailValid = formValidation.validateEmail(email)
        let isPasswordValid = formValidation.validatePassword(password)
        // Mark validation errors
        if !isEmailValid { wrongEmail = true }
        if !isPasswordValid { wrongPassword = true }

        // Use guard to stop execution if either validation fails
        guard isEmailValid, isPasswordValid else {
            return
        }
        
        _ = try await authManager.createUser(email: email, password: password)
        _ = try await membersCollector.addMember(name: name, surname: lastName, email: email)
    }
}
