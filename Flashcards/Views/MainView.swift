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
                DashboardView()
                    .tabItem {
                        Label("Dashboard", systemImage: "calendar")
                    }
                
                QuestionCardView(viewModel: viewModel)
                    .tabItem {
                        Label("Quiz", systemImage: "questionmark.circle")
                    }
                    .task {
                        await viewModel.loadQuestions()
                    }
            }
        }
    }
}

#Preview {
    MainView()
}
