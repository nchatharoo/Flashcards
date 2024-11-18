//
//  MainView.swift
//  Flashcards
//
//  Created by Nadheer on 14/11/2024.


import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = QuestionViewModel()
    
    var body: some View {
        NavigationStack {
            TabView {
                Tab("Dashboard", systemImage: "calendar") {
                    DashboardView(viewModel: viewModel)
                }
                
                Tab("Quiz", systemImage: "questionmark.circle") {
                    QuestionCardView(viewModel: viewModel)
                }
            }
            .navigationTitle("Welcome champ !")
            .navigationBarTitleDisplayMode(.large)
        }
        .task {
            await viewModel.loadQuestions()
        }
    }
}

#Preview {
    MainView()
}
