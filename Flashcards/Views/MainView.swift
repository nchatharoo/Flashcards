//
//  MainView.swift
//  Flashcards
//
//  Created by Nadheer on 14/11/2024.


import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = ViewModelFactory.makeQuestionViewModel()
    
    var body: some View {
        NavigationStack {
            TabView {
                Tab("Dashboard", systemImage: "calendar") {
                    DashboardView(viewModel: viewModel)
                        .padding(.horizontal, 20)

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

enum ViewModelFactory {
    @MainActor static func makeQuestionViewModel() -> QuestionViewModel {
        let questionRepo = RemoteQuestionRepository(service: APIService.shared)
        let answerRepo = LocalAnswerRepository(storage: LocalStorage.shared)
        let useCases = QuestionUseCases(
            questionRepository: questionRepo,
            answerRepository: answerRepo
        )
        return QuestionViewModel(useCases: useCases)
    }
}

#Preview {
    MainView()
}
