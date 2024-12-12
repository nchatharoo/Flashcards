//
//  WeekdayHeaderView.swift
//  Flashcards
//
//  Created by Nadheer on 14/11/2024.
//

import SwiftUI

struct WeekdayHeaderView: View {
    var calendar: Calendar
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        HStack {
            ForEach(0..<7) { index in
                let dayName = calendar.shortWeekdaySymbols[index]
                Text(dayName)
                    .foregroundStyle(Color(#colorLiteral(red: 0.9999960065, green: 0.9998990893, blue: 0.9968855977, alpha: 1)))
                    .frame(maxWidth: .infinity)
            }
        }
    }
}
