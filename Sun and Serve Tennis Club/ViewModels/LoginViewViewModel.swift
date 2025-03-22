import SwiftUI

@MainActor
final class LoginViewViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var wrongEmail: Bool = false
    @Published var wrongPassword: Bool = false
    @Published var authError: Bool = false
    @Published var authErrorMessage: String = ""
    @Published var success: Bool = false
    @Published var isLoggedIn: Bool = false
    @Published var name: String = ""
    
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
    
    func logIn() async throws {
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
        do {
            _ = try await authManager.logIn(email: email, password: password)
            authError = false
            authErrorMessage = ""
            success = true
        } catch {
            authError = true
            authErrorMessage = error.localizedDescription
        }
    }
    
    func logOut() throws {
        do {
            _ = try authManager.logOut()
            isLoggedIn = false
        } catch {
            
        }
    }
    
    func checkLoginStatus() async {
        do {
            let user = try authManager.getUser()
            isLoggedIn = true
            email = user.email ?? ""
            name =  await membersCollector.getMemberName(email: email)
            
        } catch {
            isLoggedIn = false
        }
    }
}
