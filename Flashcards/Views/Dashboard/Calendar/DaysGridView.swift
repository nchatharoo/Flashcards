//
//  DaysGridView.swift
//  Flashcards
//
//  Created by Nadheer on 14/11/2024.
//

import SwiftUI

struct DaysGridView: View {
    var currentMonthDates: [Date]
    var calendar: Calendar
    var animation: Namespace.ID
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
            let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: Date()))!
            let weekdayOffset = calendar.component(.weekday, from: firstDayOfMonth) - calendar.firstWeekday
            
            ForEach(0..<((weekdayOffset + 8) % 7), id: \.self) { _ in
                Text("")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundStyle(Color(colorScheme == .dark ? Color(#colorLiteral(red: 0.9999960065, green: 0.9998990893, blue: 0.9968855977, alpha: 1)) : (Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))))
            }
            
            ForEach(currentMonthDates, id: \.self) { date in
                DayView(date: date, calendar: calendar)
            }
        }
    }
}
