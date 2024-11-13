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
    @Published var questions: [Question] = []
    @Published var currentIndex = 0
    @Published var isLoading = false
    @Published var error: Error?
    @Published var selectedAnswers: [String: Int] = [:]
    @Published var answeredQuestions: Set<String> = []
    
    var currentQuestion: Question? {
        guard questions.indices.contains(currentIndex) else { return nil }
        return questions[currentIndex]
    }
    
    func loadQuestions() async {
        isLoading = true
        do {
            questions = try await APIService.shared.fetchQuestions()
            isLoading = false
        } catch {
            self.error = error
            isLoading = false
        }
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
        }
    }
    
    func shouldShowAnswer(for questionId: String) -> Bool {
        return answeredQuestions.contains(questionId)
    }
}

extension QuestionViewModel {
    static var preview: QuestionViewModel {
        let vm = QuestionViewModel()
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
