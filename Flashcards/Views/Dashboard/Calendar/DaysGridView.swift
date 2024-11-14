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
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
            // Calcul des espaces vides avant le premier jour du mois
            let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: Date()))!
            let weekdayOffset = calendar.component(.weekday, from: firstDayOfMonth) - calendar.firstWeekday
            
            // Ajouter des cases vides pour aligner les jours correctement
            ForEach(0..<((weekdayOffset + 8) % 7), id: \.self) { _ in
                Text("")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
            // Ajouter les jours du mois
            ForEach(currentMonthDates, id: \.self) { date in
                DayView(date: date, calendar: calendar)
            }
        }
    }
}
