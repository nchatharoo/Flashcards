//
//  OptionButton.swift
//  Flashcards
//
//  Created by Nadheer on 12/11/2024.
//

import SwiftUI

struct OptionButton: View {
    let text: String
    let isSelected: Bool
    let isCorrect: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .frame(maxWidth: .infinity)
                .padding()
                .background(backgroundColor)
                .foregroundStyle(isSelected ? .white : Color(#colorLiteral(red: 0, green: 0.1550326347, blue: 0.1517512798, alpha: 1)))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(borderColor, lineWidth: 2)
                )
        }
        .disabled(isCorrect)
    }
    
    private var backgroundColor: Color {
        if isCorrect {
            return .green
        } else if isSelected {
            return .red
        }
        return Color(#colorLiteral(red: 0.9854046702, green: 0.7808517218, blue: 0.4496312737, alpha: 1))
    }
    
    private var borderColor: Color {
        if isCorrect {
            return .green
        } else if isSelected {
            return .white
        }
        return .clear
    }
}
