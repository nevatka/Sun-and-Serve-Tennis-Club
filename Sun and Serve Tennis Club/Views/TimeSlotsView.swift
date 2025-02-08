import SwiftUI

struct TimeSlotsView: View {
    @State private var selectedTime: String? = nil // Track selected time
    
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
                            .background(selectedTime == timeSlot ? Color.accentColor : .white)
                            .cornerRadius(12)
                            .foregroundColor(selectedTime == timeSlot ? .white : .primary)
                            .onTapGesture {
                                selectedTime = timeSlot
                            }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

#Preview {
    TimeSlotsView()
}
