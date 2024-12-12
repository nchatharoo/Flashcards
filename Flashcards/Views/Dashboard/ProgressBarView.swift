//
//  ProgressBarView.swift
//  Flashcards
//
//  Created by Nadheer on 18/11/2024.
//

import SwiftUI

struct ProgressBarView: View {
    var category: Question.Category
    var score: (correct: Int, total: Int)
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(alignment: .leading) {
            Text(category.rawValue.capitalized)
                .font(.headline)
                .padding(.bottom, 5)
                .foregroundStyle(Color(colorScheme == .dark ? Color(#colorLiteral(red: 0.9999960065, green: 0.9998990893, blue: 0.9968855977, alpha: 1)) : (Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))))

            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 20)
                    .foregroundStyle(Color(#colorLiteral(red: 0, green: 0.3411764706, blue: 0.3333333333, alpha: 1)))
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: progressWidth(), height: 20)
                    .foregroundStyle(Color(#colorLiteral(red: 0.9854046702, green: 0.7808517218, blue: 0.4496312737, alpha: 1)))
            }
            .animation(.easeInOut, value: score.correct)
        }
        .padding(.horizontal, 20)
    }
    
    private func progressWidth() -> CGFloat {
        guard score.total > 0 else { return 0 }
        let percentage = Double(score.correct) / Double(score.total)
        let availableWidth = UIScreen.main.bounds.width - 40
        return CGFloat(percentage) * availableWidth
    }
}

#Preview {
    ProgressBarView(category: Question.Category.dataStructures, score: (1, 10))
}
