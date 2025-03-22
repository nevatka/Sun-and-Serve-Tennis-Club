import SwiftUI

struct ReservationView: View {
    
    @Binding var isPresented: Bool
    @EnvironmentObject var loginViewModel: LoginViewViewModel
    @StateObject private var viewModel = ReservationViewViewModel()

    var body: some View {
        VStack (spacing: 40) {
            
            CalendarDaysView(viewModel: viewModel)
             TimeSlotsView(viewModel: viewModel)
            
            HStack(spacing: 70){
                
                Button {
                    isPresented = false
                } label: {
                    Text("Cancel")
                        .buttonCancelStyle()
                }
                
                Button(action: {
                    Task {
                        await viewModel.addReservation(for: loginViewModel.email)
                    }
                }) {
                    Text("Confirm")
                        .buttonConfirmStyle()
                }
                
                .alert("You can't add more than 3 reservations. ", isPresented: $viewModel.tooManyReservations) {
                    Button("OK", role: .cancel) {}
                }
            }
        }
        .environmentObject(loginViewModel)
        
    }
}
