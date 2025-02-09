import SwiftUI

struct RegisterView: View {
    
    @StateObject private var viewModel = RegisterViewViewModel()
    @State private var name = ""
    @State private var lastName = ""
    @State private var backToMainPage: Bool = false
    
    var body: some View {
        VStack(spacing: -50) {
            
            ImageView(imageName: "logo")
            
            VStack {
                TextField("Name", text: $name)
                    .loginFieldsStyle()
                
                TextField("Last Name", text: $lastName)
                    .loginFieldsStyle()
                
                TextField("Email", text: $viewModel.email)
                    .loginFieldsStyle()
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                
                SecureField("Password", text: $viewModel.password)
                    .loginFieldsStyle()
                
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
