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
    
    var body: some View {
        HStack {
            ForEach(dates, id: \.self) { date in
                DayView(date: date, calendar: calendar)
            }
        }
    }
}
