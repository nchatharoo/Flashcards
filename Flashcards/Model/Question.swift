//
//  Question.swift
//  Flashcards
//
//  Created by Nadheer on 12/11/2024.
//

import Foundation

public struct Question: Codable, Identifiable, Equatable {
    public let id: String
    let question: String
    let options: [String]
    let correctAnswer: Int
    let explanation: String
    let category: Category
    
    enum Category: String, Codable, CaseIterable {
        case arrays
        case linkedLists = "linkedLists"
        case trees
        case graphs
        case sorting
        case searching
        case dynamicProgramming = "dynamicProgramming"
        case heaps
        case dataStructures
        case hashTables = "hashTables"
    }
    
    var uuid: UUID {
        UUID(uuidString: id) ?? UUID()
    }
}

extension Question {
    static let sample = Question(
        id: "1",
        question: "Quelle est la complexité temporelle moyenne d'un QuickSort ?",
        options: ["O(n)", "O(n log n)", "O(n²)", "O(log n)"],
        correctAnswer: 1,
        explanation: "QuickSort a une complexité moyenne de O(n log n)",
        category: .sorting
    )
}
