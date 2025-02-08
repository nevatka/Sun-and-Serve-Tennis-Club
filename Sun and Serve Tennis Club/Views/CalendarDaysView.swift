import SwiftUI

struct CalendarDaysView: View {
    @State private var selectedDate = Date() // Track the selected date
    
    private let calendar = Calendar.current
    private let daysRange: [Date] = {
        let today = Date()
        let startOfWeek = Calendar.current.startOfDay(for: today)
        return (0..<7).map { Calendar.current.date(byAdding: .day, value: $0, to: startOfWeek)! }
    }()
    
    private func isSelected(_ date: Date) -> Bool {
        calendar.isDate(date, inSameDayAs: selectedDate)
    }
    
    private func dayOfWeek(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E" // Short weekday name, e.g., "Mon", "Tue"
        return formatter.string(from: date).uppercased()
    }
    
    private func dayOfMonth(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d" // Day number, e.g., "13"
        return formatter.string(from: date)
    }
    
    var body: some View {
        VStack {
            Label("Select a reservation date", systemImage: "calendar")
                .font(.custom("PTSerif-Regular", size: 20))
                .foregroundStyle(.gray)
            // Horizontally swipeable calendar
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(daysRange, id: \.self) { date in
                        VStack {
                            Text(dayOfMonth(from: date))
                                .font(.custom("PTSerif-Regular", size: 20))
                                .foregroundColor(isSelected(date) ? .white : .primary)
                            
                            Text(dayOfWeek(from: date))
                                .font(.custom("PTSerif-Regular", size: 14))
                                .foregroundColor(isSelected(date) ? .white : .secondary)
                        }
                        .frame(width: 60, height: 80)
                        .background(isSelected(date) ? Color.accentColor : Color.clear)
                        .cornerRadius(12)
                        .onTapGesture {
                            selectedDate = date
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

// Date formatter for display
private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .full
    return formatter
}()
    
    
#Preview {
    CalendarDaysView()
}
