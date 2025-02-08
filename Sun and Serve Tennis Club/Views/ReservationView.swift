import SwiftUI

struct ReservationView: View {
    @Binding var isPresented: Bool
    @State private var showingAlert: Bool = false
    var body: some View {
        VStack (spacing: 40) {
            
            CalendarDaysView()
        
            TimeSlotsView()
            
            HStack(spacing: 70){
                
                Button {
                    isPresented = false
                } label: {
                    Text("Cancel")
                        .buttonCancelStyle()
                }
                
                Button {
                    showingAlert = true
                } label: {
                    Text("Confirm")
                        .buttonConfirmStyle()
                }
                
                .alert("Do you confirm this reservation?", isPresented: $showingAlert) {
                    Button("Yes, I Confirm") {}
                    Button("Cancel", role: .cancel) {}
                    
                }
            }
        }
        
    }
}
