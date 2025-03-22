import SwiftUI

struct TimeSlotsView: View {
    
    @ObservedObject var viewModel: ReservationViewViewModel
    
    let timeSlots = [
        "10:00-11:00",
        "12:45-13:45",
        "16:30-17:30",
        "19:00-20:00"
    ]
    
    var body: some View {
        VStack {
            Label("Select a time slot", systemImage: "alarm")
                .font(.custom("PTSerif-Regular", size: 20))
                .foregroundStyle(.gray)
            // Horizontally scrollable time slots
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(timeSlots, id: \.self) { timeSlot in
                        Text(timeSlot)
                            .font(.custom("PTSerif-Regular", size: 20))
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(viewModel.selectedTimeSlot == timeSlot ? Color.accentColor : .white)
                            .cornerRadius(12)
                            .foregroundColor(viewModel.selectedTimeSlot == timeSlot ? .white : .primary)
                            .onTapGesture {
                                viewModel.selectedTimeSlot = timeSlot
                            }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}
