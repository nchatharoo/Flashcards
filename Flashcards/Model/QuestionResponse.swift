//
//  QuestionResponse.swift
//  Flashcards
//
//  Created by Nadheer on 12/11/2024.
//

import Foundation

struct QuestionResponse: Codable {
    let questions: [Question]
    let version: String
}
