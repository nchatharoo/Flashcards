//
//  QuestionViewModel.swift
//  Flashcards
//
//  Created by Nadheer on 12/11/2024.
//

import Foundation
import SwiftUI

@MainActor
class QuestionViewModel: ObservableObject {
    private let useCases: QuestionUseCases

    @Published var questions: [Question] = []
    @Published var currentIndex = 0
    @Published var isLoading = false
    @Published var error: Error?
    @Published var selectedAnswers: [String: Int] = [:]
    @Published var answeredQuestions: Set<String> = []
    
    init(useCases: QuestionUseCases) {
        self.useCases = useCases
        Task {
            await loadSavedAnswers()
        }
    }
    
    var currentQuestion: Question? {
        guard questions.indices.contains(currentIndex) else { return nil }
        return questions[currentIndex]
    }
    
    func loadQuestions() async {
        isLoading = true
        do {
            questions = try await useCases.fetchQuestions()
            isLoading = false
        } catch {
            self.error = error
            isLoading = false
        }
    }

    private func loadSavedAnswers() async {
        let saved = await useCases.loadSavedAnswers()
        self.selectedAnswers = saved.selectedAnswers
        self.answeredQuestions = saved.answeredQuestions
    }    
    
    func nextQuestion() {
        withAnimation(.spring()) {
            if currentIndex < questions.count - 1 {
                currentIndex += 1
            }
        }
    }
    
    func previousQuestion() {
        withAnimation(.spring()) {
            if currentIndex > 0 {
                currentIndex -= 1
            }
        }
    }

    func selectAnswer(for questionId: String, answerIndex: Int) {
        withAnimation {
            selectedAnswers[questionId] = answerIndex
            answeredQuestions.insert(questionId)
            Task {
                await useCases.saveAnswer(
                    selectedAnswers: selectedAnswers,
                    answeredQuestions: answeredQuestions
                )
            }
        }
    }
    
    func shouldShowAnswer(for questionId: String) -> Bool {
        return answeredQuestions.contains(questionId)
    }
    
    func calculateScore() -> (correct: Int, total: Int) {
        let scoreByCategory = calculateScoreByCategory()

        let correctAnswers = scoreByCategory.values.reduce(0) { $0 + $1.correct }
        let totalQuestions = scoreByCategory.values.reduce(0) { $0 + $1.total }

        return (correctAnswers, totalQuestions)
    }
    
    func calculateScoreByCategory() -> [Question.Category: (correct: Int, total: Int)] {
        var scoreByCategory: [Question.Category: (correct: Int, total: Int)] = [:]
        
        for category in Question.Category.allCases {
            scoreByCategory[category] = (correct: 0, total: 0)
        }

        for question in questions {
            let category = question.category
            if let selectedIndex = selectedAnswers[question.id] {
                scoreByCategory[category]?.total += 1
                
                if selectedIndex == question.correctAnswer {
                    scoreByCategory[category]?.correct += 1
                }
            }
        }

        return scoreByCategory
    }
}

extension QuestionViewModel {
    static var preview: QuestionViewModel {
        let vm = ViewModelFactory.makeQuestionViewModel()
        vm.questions = [
            .init(
                id: "1",
                question: "Quelle est la complexité de QuickSort?",
                options: ["O(n)", "O(n log n)", "O(n²)", "O(1)"],
                correctAnswer: 1,
                explanation: "QuickSort est en O(n log n) en moyenne",
                category: .sorting
            ),
            .init(
                id: "2",
                question: "Qu'est-ce qu'une liste chaînée?",
                options: ["Un tableau", "Une structure avec des noeuds", "Un arbre", "Un graphe"],
                correctAnswer: 1,
                explanation: "Une liste chaînée est une séquence de noeuds",
                category: .linkedLists
            )
        ]
        return vm
    }
}
