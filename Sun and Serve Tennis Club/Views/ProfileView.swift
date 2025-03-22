import SwiftUI
import FirebaseFirestore

struct ProfileView: View {
    
    @EnvironmentObject var viewModel: LoginViewViewModel
    @StateObject private var reservationViewModel = ReservationViewViewModel()
    @State private var reservations: [Timestamp] = []
    
    var body: some View {
        VStack (spacing: 30){
            Text("Hi \(viewModel.name)!")
                .font(.custom("PTSerif-Regular", size: 20))
                .foregroundStyle(Color.accentColor)
                .padding(.top, 30)
            
            
            if reservations.isEmpty {
                Text("No reservations yet.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                Text("Your current reservations")
                    .font(.custom("PTSerif-Regular", size: 20))
                    .foregroundStyle(Color.accentColor)
                List {
                    ForEach(reservations, id: \.self) { timestamp in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(formatTimestamp(timestamp))
                                    .font(.custom("PTSerif-Regular", size: 16))
                                    .foregroundColor(Color.accentColor)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal)
                                    .background(Color.white)
                                    .cornerRadius(10)
                            }
                            .padding(.horizontal)
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                Task {
                                    await deleteReservation(timestamp)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
                .frame(height: 250) // Limit list height
                .listStyle(PlainListStyle()) // Remove default list styles
            }
            
            Spacer()
            
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
                    .font(.custom("PTSerif-Regular", size: 15))
                    
            }
            .padding(.bottom, 30)
        }
        .onAppear {
            Task {
                reservations = await reservationViewModel.getReservations(for: viewModel.email)
                reservations.sort { $0.dateValue() < $1.dateValue() }
                
            }
        }
        .environmentObject(viewModel)
    }
    private func deleteReservation(_ timestamp: Timestamp) async {
        guard let index = reservations.firstIndex(of: timestamp) else { return }
        
        // Remove from local state
        reservations.remove(at: index)
        
        // Call your delete logic from Firestore, assuming `deleteReservation` exists in your ViewModel
        await reservationViewModel.deleteReservation(for: viewModel.email, time: timestamp)
    }
}

private func formatTimestamp(_ timestamp: Timestamp) -> String {
    let date = timestamp.dateValue()
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE, MMM d, yyyy - h:mm a"
    return formatter.string(from: date)
}

