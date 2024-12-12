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
            
            WeekdayHeaderView(calendar: calendar)
                .padding(.horizontal)
            
            if isExpanded {
                DaysGridView(currentMonthDates: currentMonthDates, calendar: calendar, animation: animation)
                    .padding(.horizontal)
            } else {
                CompactDaysView(dates: getRecentDays(), calendar: calendar, animation: animation)
                    .padding(.horizontal)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: isExpanded ? 450 : 150)
        .background(Color(#colorLiteral(red: 0, green: 0.3414323926, blue: 0.3324367404, alpha: 1)))
        .cornerRadius(16)
        .shadow(radius: 8)
        .padding()
        .zIndex(1)
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
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: Date())
    }
    
    private func getRecentDays() -> [Date] {
        let today = Date()
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)
        let startOfWeek = calendar.date(from: components) ?? today
        let sunday = calendar.date(byAdding: .weekday, value: -(calendar.component(.weekday, from: startOfWeek) - 1), to: startOfWeek) ?? today
        
        var days: [Date] = []
        for i in 0..<7 {
            if let newDate = calendar.date(byAdding: .day, value: i, to: sunday) {
                days.append(newDate)
            }
        }
        
        return days
    }
}

#Preview {
    @Previewable @Namespace var animation

    CalendarView(isExpanded: .constant(false), animation: animation)
        .background(Color(#colorLiteral(red: 0, green: 0.3414323926, blue: 0.3324367404, alpha: 1)))

}
