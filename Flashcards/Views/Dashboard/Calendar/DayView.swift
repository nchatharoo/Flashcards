//
//  DayView.swift
//  Flashcards
//
//  Created by Nadheer on 14/11/2024.
//

import SwiftUI

struct DayView: View {
    var date: Date
    var calendar: Calendar

    var body: some View {
        VStack {
            Text("\(calendar.component(.day, from: date))")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(8)
                .background(isToday(date) ? Color(#colorLiteral(red: 0.9854046702, green: 0.7808517218, blue: 0.4496312737, alpha: 1)) : Color.clear)
                .cornerRadius(8)
                .foregroundStyle(isToday(date) ? Color(#colorLiteral(red: 0, green: 0.1550326347, blue: 0.1517512798, alpha: 1)) : Color(#colorLiteral(red: 0.9999960065, green: 0.9998990893, blue: 0.9968855977, alpha: 1)))
        }
    }
    
    private func isToday(_ date: Date) -> Bool {
        calendar.isDateInToday(date)
    }
}
