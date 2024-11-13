//
//  ContentView.swift
//  Flashcards
//
//  Created by Nadheer on 12/11/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = QuestionViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    QuestionCardView(viewModel: viewModel)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {

                    }) {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(Color(#colorLiteral(red: 0.9999960065, green: 0.9998990893, blue: 0.9968855977, alpha: 1)))
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    let score = viewModel.calculateScore()
                    Text("Score: \(score.correct)/\(score.total)")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(Color(#colorLiteral(red: 0.9999960065, green: 0.9998990893, blue: 0.9968855977, alpha: 1)))
                }
            }
            .background(Color(#colorLiteral(red: 0, green: 0.3414323926, blue: 0.3324367404, alpha: 1)))
        }
        .task {
            await viewModel.loadQuestions()
        }
    }
}

#Preview {
    ContentView()
}
