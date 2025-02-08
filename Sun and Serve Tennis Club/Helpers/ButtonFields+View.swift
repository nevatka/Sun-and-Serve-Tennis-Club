import SwiftUI

struct ButtonFieldsConfirm: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.accentColor)
            .cornerRadius(25)
            .font(.custom("PTSerif-Regular", size: 18))
            .padding(.horizontal, 30)
    }
}

struct ButtonFieldsCancel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.gray)
            .cornerRadius(25)
            .font(.custom("PTSerif-Regular", size: 18))
            .padding(.horizontal, 30)
    }
}

extension View {
    func buttonConfirmStyle() -> some View {
        modifier(ButtonFieldsConfirm())
    }
    
    func buttonCancelStyle() -> some View {
        modifier(ButtonFieldsCancel())
    }
}
