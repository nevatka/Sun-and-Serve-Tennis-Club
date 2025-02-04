import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: -50) {
                ImageView(imageName: "logo")
                
                VStack {
                    
                    TextField("Email", text: $email)
                        .loginFieldsStyle()
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                    
                    SecureField("Password", text: $password)
                        .loginFieldsStyle()
                    
                    Button(action: {
                        
                    }) {
                        Text("LOG IN")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .cornerRadius(25)
                            .padding(.horizontal, 30)
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
        }
        
    }
}


#Preview {
    LoginView()
}

