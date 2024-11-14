//
//  CompactDaysView.swift
//  Flashcards
//
//  Created by Nadheer on 14/11/2024.
//

import SwiftUI

struct CompactDaysView: View {
    var dates: [Date]
    var calendar: Calendar
    var animation: Namespace.ID
    let formatter = DateFormatter()
    
    var body: some View {
        HStack {
            ForEach(dates, id: \.self) { date in
                VStack {
                    Text(shortDayOfWeek(for: date))
                        .foregroundStyle(Color(#colorLiteral(red: 0.9999960065, green: 0.9998990893, blue: 0.9968855977, alpha: 1)))
                    Text("\(calendar.component(.day, from: date))")
                        .padding(8)
                        .background(isToday(date) ? Color(#colorLiteral(red: 0.9854046702, green: 0.7808517218, blue: 0.4496312737, alpha: 1)) : Color.clear)
                        .cornerRadius(8)
                        .foregroundColor(isToday(date) ? Color(#colorLiteral(red: 0, green: 0.1550326347, blue: 0.1517512798, alpha: 1)) : Color(#colorLiteral(red: 0.9999960065, green: 0.9998990893, blue: 0.9968855977, alpha: 1)))
                }
            }
        }
        .matchedGeometryEffect(id: "calendar", in: animation)
    }
    
    private func shortDayOfWeek(for date: Date) -> String {
        formatter.dateFormat = "E"
        return formatter.string(from: date)
    }
    
    private func isToday(_ date: Date) -> Bool {
        calendar.isDateInToday(date)
    }
}
