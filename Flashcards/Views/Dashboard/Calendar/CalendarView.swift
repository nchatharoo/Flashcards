//
//  CalendarView.swift
//  Flashcards
//
//  Created by Nadheer on 14/11/2024.
//

import SwiftUI

struct CalendarView: View {
    @Binding var isExpanded: Bool
    var animation: Namespace.ID
    private let calendar = Calendar.current
    private let currentMonthDates: [Date]
    let formatter = DateFormatter()
    
    init(isExpanded: Binding<Bool>, animation: Namespace.ID) {
        self._isExpanded = isExpanded
        self.animation = animation
        self.currentMonthDates = Self.generateCurrentMonthDates()
    }
    
    var body: some View {
        VStack {
            HeaderView(currentMonthAndYear: currentMonthAndYear(), animation: animation)
                .padding()
            
            if isExpanded {
                WeekdayHeaderView(calendar: calendar)
                    .padding(.horizontal)
                
                DaysGridView(currentMonthDates: currentMonthDates, calendar: calendar, animation: animation)
                    .padding(.horizontal)
            } else {
                CompactDaysView(dates: getRecentDays(), calendar: calendar, animation: animation)
                    .padding(.horizontal)
            }
        }
        .padding()
    }
    
    private static func generateCurrentMonthDates() -> [Date] {
        let calendar = Calendar.current
        let now = Date()
        let range = calendar.range(of: .day, in: .month, for: now)!
        return range.compactMap { day -> Date? in
            calendar.date(bySetting: .day, value: day, of: now)
        }
    }
    
    private func currentMonthAndYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: Date())
    }
    
    private func getRecentDays() -> [Date] {
        let today = Date()
        var days: [Date] = []
        for i in -3...3 {
            if let newDate = calendar.date(byAdding: .day, value: i, to: today) {
                days.append(newDate)
            }
        }
        return days
    }
}

#Preview {
    @Previewable @Namespace var animation
    CalendarView(isExpanded: .constant(true), animation: animation)
        .background(Color(#colorLiteral(red: 0, green: 0.3414323926, blue: 0.3324367404, alpha: 1)))

}
