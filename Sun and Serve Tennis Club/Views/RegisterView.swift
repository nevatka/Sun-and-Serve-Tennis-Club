import SwiftUI

struct RegisterView: View {
    @State private var name = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
            VStack(spacing: -50) {
                
                ImageView(imageName: "logo")
                
                VStack {
                    TextField("Name", text: $name)
                        .loginFieldsStyle()
                    
                    TextField("Last Name", text: $lastName)
                        .loginFieldsStyle()
                    
                    TextField("Email", text: $email)
                        .loginFieldsStyle()
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                    
                    SecureField("Password", text: $password)
                        .loginFieldsStyle()
                    
                    Button(action: {
                        
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
            }
        }

#Preview {
    RegisterView()
}
