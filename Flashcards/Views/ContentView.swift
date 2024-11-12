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
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                QuestionCardView(viewModel: viewModel)
            }
        }
        .task {
            await viewModel.loadQuestions()
        }
    }
}
#Preview {
    ContentView()
}
