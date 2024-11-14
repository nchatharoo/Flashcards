//
//  HeaderView.swift
//  Flashcards
//
//  Created by Nadheer on 14/11/2024.
//

import SwiftUI

struct HeaderView: View {
    var currentMonthAndYear: String
    var animation: Namespace.ID
    
    var body: some View {
        HStack {
            Text(currentMonthAndYear)
                .foregroundStyle(Color(#colorLiteral(red: 0.9999960065, green: 0.9998990893, blue: 0.9968855977, alpha: 1)))
                .font(.title2)
                .bold()
                .padding(.leading, 10)
                .matchedGeometryEffect(id: "title", in: animation)
            Spacer()
        }
    }
}
