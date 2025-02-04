import SwiftUI

struct LoginFields: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(25)
            .padding(.horizontal, 30)
    }
}

extension View {
    func loginFieldsStyle() -> some View {
        modifier(LoginFields())
    }
}
