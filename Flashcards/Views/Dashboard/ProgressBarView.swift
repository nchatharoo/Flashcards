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

    var body: some View {
        VStack(alignment: .leading) {
            Text(category.rawValue.capitalized)
                .font(.headline)
                .padding(.bottom, 5)
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 20)
                    .foregroundColor(Color(#colorLiteral(red: 0.6705882353, green: 0.8196078431, blue: 0.7764705882, alpha: 1)))
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: progressWidth(), height: 20)
                    .foregroundColor(Color(#colorLiteral(red: 0.9854046702, green: 0.7808517218, blue: 0.4496312737, alpha: 1)))
            }
            .animation(.easeInOut, value: score.correct)
        }
        .padding(.vertical, 5)
    }
    
    private func progressWidth() -> CGFloat {
        guard score.total > 0 else { return 0 }
        let percentage = Double(score.correct) / Double(score.total)
        return CGFloat(percentage) * UIScreen.main.bounds.width * 1
    }
}

#Preview {
    ProgressBarView(category: Question.Category.dataStructures, score: (1, 10))
}
