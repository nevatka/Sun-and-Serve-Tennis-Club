import SwiftUI

struct OpeningHoursView: View {
    @State private var isOpen: Bool = false
    
    let openingHours: [String: (start: String, end: String)] = [
        "MON": ("10:00", "22:00"),
        "TUE": ("10:00", "20:00"),
        "WED": ("10:00", "20:00"),
        "THU": ("10:00", "20:00"),
        "FRI": ("10:00", "20:00"),
        "SAT": ("10:00", "22:00"),
        "SUN": ("10:00", "22:00")
    ]
    let weekdayOrder = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]

    
    var body: some View {
        VStack{
            Text("We are currently")
                .font(.custom("PTSerif-Regular", size: 20))
                .foregroundStyle(.gray)
            
            Text(isOpen ? "OPEN" : "CLOSED")
                .font(.custom("PTSerif-Regular", size: 30))
                .foregroundStyle(Color.accentColor)
            
            VStack(alignment: .trailing, spacing: 10) {
                ForEach(openingHours.sorted(by: {
                    weekdayOrder.firstIndex(of: $0.key) ?? 0 < weekdayOrder.firstIndex(of: $1.key) ?? 0
                }), id: \.key) { day, hours in
                    HStack (spacing: 70) {
                        Text(day)
                            .font(.custom("PTSerif-Regular", size: 15))
                            .foregroundStyle(.gray)
                        Text("\(hours.start) - \(hours.end)")
                            .font(.custom("PTSerif-Regular", size: 18))
                            .foregroundStyle(Color.accentColor)
                    }
                }
            }
            .padding(.top, 20)
        }
        .onAppear {
            isOpen = checkIfOpen()
        }
    }
    
    // will me moved to helpers
    func checkIfOpen() -> Bool {
        let current = Calendar.current
        let now = Date()
        let weekday = current.component(.weekday, from: now)
        let dayNames = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
        
        guard let today = dayNames[safe: weekday - 1],
              let hours = openingHours[today],
              let openTime = getTime(hours.start),
              let closeTime = getTime(hours.end) else { return false }
        
        return now >= openTime && now <= closeTime
    }
    
    func getTime(_ time: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"

        guard let parsedTime = formatter.date(from: time) else { return nil }

        // Get the current date components
        let calendar = Calendar.current
        let now = Date()
        var components = calendar.dateComponents([.year, .month, .day], from: now)

        // Extract hour and minute from parsedTime
        let timeComponents = calendar.dateComponents([.hour, .minute], from: parsedTime)
        components.hour = timeComponents.hour
        components.minute = timeComponents.minute
        
        print("Day " , components.day)
        
        print("Get time: ", calendar.date(from: components))

        return calendar.date(from: components) // Returns a Date object with today's date
    }
}

#Preview {
    OpeningHoursView()
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
