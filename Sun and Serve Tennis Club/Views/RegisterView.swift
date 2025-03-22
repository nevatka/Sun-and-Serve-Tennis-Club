import SwiftUI

struct RegisterView: View {
    
    @StateObject private var viewModel = RegisterViewViewModel()
    @State private var backToMainPage: Bool = false
    
    var body: some View {
        VStack(spacing: -50) {
            
            ImageView(imageName: "logo")
            
            VStack {
                TextField("Name", text: $viewModel.name)
                    .loginFieldsStyle()
                
                TextField("Last Name", text: $viewModel.lastName)
                    .loginFieldsStyle()
                
                TextField("Email", text: $viewModel.email)
                    .loginFieldsStyle()
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .onChange(of: viewModel.email) {
                        viewModel.wrongEmail = !FormValidation().validateEmail(viewModel.email)
                    }
                
                if viewModel.wrongEmail {
                    Text("Wrong email format")
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
                
                Button(action: {
                    Task {
                        try await viewModel.signIn()
                    }
                    backToMainPage = true
                }) {
                    Text("SIGN IN")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .cornerRadius(25)
                        .padding(.horizontal, 30)
                        .disabled(viewModel.password.isEmpty || viewModel.email.isEmpty || viewModel.wrongEmail || viewModel.wrongPassword)
                    
                }
                .padding(.top, 10)
                
            }
            
            Spacer()
        }
        .padding([.leading, .trailing, .top])
        .padding(.bottom, 200)
        .fullScreenCover(isPresented: $backToMainPage) {
            MainView()
            
        }
    }
            
        
}

#Preview {
    RegisterView()
}
