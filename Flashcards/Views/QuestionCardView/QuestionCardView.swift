//
//  QuestionCardView.swift
//  Flashcards
//
//  Created by Nadheer on 12/11/2024.
//

import SwiftUI

struct QuestionCardView: View {
    @ObservedObject var viewModel: QuestionViewModel
    
    var body: some View {
        GeometryReader { geometry in
            TabView(selection: $viewModel.currentIndex) {
                ForEach(Array(viewModel.questions.enumerated()), id: \.element.id) { index, question in
                    VStack(spacing: 20) {
                        Text(question.question)
                            .font(.title2)
                            .padding()
                            .foregroundStyle(Color(#colorLiteral(red: 0.9999960065, green: 0.9998990893, blue: 0.9968855977, alpha: 1)))
                            .multilineTextAlignment(.center)
                        
                        VStack(spacing: 12) {
                            ForEach(Array(question.options.enumerated()), id: \.offset) { optionIndex, option in
                                OptionButton(
                                    text: option,
                                    isSelected: viewModel.selectedAnswers[question.id] == optionIndex,
                                    isCorrect: viewModel.answeredQuestions.contains(question.id) && optionIndex == question.correctAnswer,
                                    action: {
                                        viewModel.selectAnswer(for: question.id, answerIndex: optionIndex)
                                    }
                                )
                            }
                        }
                        .padding([.horizontal, .bottom])
                        
                        if viewModel.shouldShowAnswer(for: question.id) {
                            Text(question.explanation)
                                .font(.callout)
                                .foregroundStyle(Color(#colorLiteral(red: 0.9999960065, green: 0.9998990893, blue: 0.9968855977, alpha: 1)))
                                .padding()
                                .transition(.opacity)
                        }
                    }
                    .frame(
                        width: geometry.size.width - 40,
                        height: min(geometry.size.height - 40, 600) // Hauteur fixe ou max
                    )
                    .background(Color(#colorLiteral(red: 0, green: 0.3414323926, blue: 0.3324367404, alpha: 1)))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 5)
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .padding(.vertical, 20)
    }
}

#Preview {
    QuestionCardView(viewModel: .preview)
}
