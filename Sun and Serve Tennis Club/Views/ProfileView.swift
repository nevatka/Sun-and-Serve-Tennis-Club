import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var viewModel: LoginViewViewModel
    
    
    var body: some View {
        Button(action: {
            Task {
                try viewModel.logOut()
            }
        }) {
            Text("LOG OUT")
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.accentColor)
                .cornerRadius(25)
                .padding(.horizontal, 30)
        }
    }
}
