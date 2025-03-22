import SwiftUI
import FirebaseFirestore

@MainActor
final class ReservationViewViewModel: ObservableObject {
    @Published var reservations: [Timestamp] = []
    @Published var selectedDate: Date? // Selected date
    @Published var selectedTimeSlot: String? // Selected time slot
    @Published var tooManyReservations: Bool = false
    
    private var membersCollector: MembersCollector

    init(
        membersCollector: MembersCollector = MembersCollector()
    ) {
        self.membersCollector = membersCollector
    }
    
    func addReservation(for email: String) async {
        
        let reservations = await getReservations(for: email)
        print(reservations.count)
        
        guard reservations.count < 4 else {
            print("Too many reservations for this user.")
            tooManyReservations = true
            return
        }
        
        guard let selectedTimeSlot = selectedTimeSlot else {
            print("Time Slot is missing")
            return
        }
        guard let selectedDate = selectedDate else {
            print("Date is missing")
            return
        }
        
    
        let timestamp = convertTimeSlotToTimestamp(date: selectedDate, timeSlot: selectedTimeSlot)
        
        await membersCollector.addReservation(for: email, time: timestamp)
    }
    
    
    private func convertTimeSlotToTimestamp(date: Date, timeSlot: String) -> Timestamp {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let timeParts = timeSlot.components(separatedBy: "-")
        guard let startTime = timeParts.first else {
            fatalError("Invalid time slot format")
        }
        
        let fullDateTimeString = "\(formatter.string(from: date).prefix(10)) \(startTime)"
        guard let dateTime = formatter.date(from: fullDateTimeString) else {
            fatalError("Could not parse date")
        }
        
        return Timestamp(date: dateTime)
    }
    
    func getReservations(for email: String) async -> Array<Timestamp> {
        return await membersCollector.getReservations(for: email)
    }
    
    func deleteReservation(for email: String, time: Timestamp) async {
        await membersCollector.deleteReservation(for: email, time: time)
    }
}
