import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: -50) {
                ImageView(imageName: "logo")
                
                VStack {
                    
                    TextField("Email", text: $viewModel.email)
                        .loginFieldsStyle()
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                            
                        .onChange(of: viewModel.email) {
                            viewModel.wrongEmail = !FormValidation().validateEmail(viewModel.email)
                        }
                    if viewModel.wrongEmail {
                        Text("Wrong Email")
                            .font(.custom("PTSerif-Regular", size: 10))
                            .foregroundStyle(Color.red)
                    }
                    

                    
                    SecureField("Password", text: $viewModel.password)
                        .loginFieldsStyle()
                        .onChange(of: viewModel.password) {
                            viewModel.wrongPassword = !FormValidation().validatePassword(viewModel.password)
                        }
                    Text("Password must be between 8 and 16 characters long")
                        .font(.custom("PTSerif-Regular", size: 10))
                        .foregroundStyle(viewModel.wrongPassword ? Color.red : Color.accentColor)
                    
                    if viewModel.authError {
                        Text(viewModel.authErrorMessage)
                            .font(.custom("PTSerif-Regular", size: 10))
                            .foregroundStyle(Color.red)
                    }

                    Button(action: {
                        Task {
                            try await viewModel.logIn()
                        }
                    }) {
                        Text("LOG IN")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .cornerRadius(25)
                            .padding(.horizontal, 30)
                            .disabled(viewModel.password.isEmpty || viewModel.email.isEmpty || viewModel.wrongEmail || viewModel.wrongPassword)
                    }
                    .padding(.top, 10)
                    
                    Text ("Forgot password?")
                        .font(.custom("PTSerif-Regular", size: 15))
                        .foregroundStyle(Color.accentColor)
                        .padding(.top, 10)
                }
                
                Spacer()
                
                NavigationLink(destination: RegisterView()) {
                    Text("Doesn't have an account? Sign Up!")
                        .font(.custom("PTSerif-Regular", size: 18))
                        .foregroundColor(Color.accentColor)
                }
            }
            .padding()
            .fullScreenCover(isPresented: $viewModel.success) {
                MainView()
            }
        }
        
    }
}


#Preview {
    LoginView()
}

