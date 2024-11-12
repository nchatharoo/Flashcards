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
                .foregroundColor(.white)
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
        return .blue
    }
    
    private var borderColor: Color {
        isSelected ? .white : .clear
    }
}
