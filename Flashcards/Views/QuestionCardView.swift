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
                            .multilineTextAlignment(.center)
                        
                        VStack(spacing: 12) {
                            ForEach(Array(question.options.enumerated()), id: \.offset) { optionIndex, option in
                                OptionButton(
                                    text: option,
                                    isSelected: viewModel.selectedAnswer == optionIndex,
                                    isCorrect: viewModel.showAnswer && optionIndex == question.correctAnswer,
                                    action: {
                                        withAnimation {
                                            viewModel.selectedAnswer = optionIndex
                                            viewModel.showAnswer = true
                                        }
                                    }
                                )
                            }
                        }
                        .padding([.horizontal, .bottom])
                        
                        if viewModel.showAnswer {
                            Text(question.explanation)
                                .font(.callout)
                                .foregroundColor(.secondary)
                                .padding()
                                .transition(.opacity)
                        }
                    }
                    .background(Color.red)
                    .cornerRadius(16)
                    .shadow(radius: 5)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .automatic))
        }
    }
}

#Preview {
    QuestionCardView(viewModel: .preview)
}
