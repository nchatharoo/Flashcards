//
//  APIService.swift
//  Flashcards
//
//  Created by Nadheer on 12/11/2024.
//

import Foundation

class APIService {
    static let shared = APIService()
    private let baseURL = "https://gist.githubusercontent.com/nchatharoo/99825731ee553c6b2d0998d768f980f0/raw/2cfc2a2479e1fe54cd4640230c8fafbc704f809a/questions.json"

    func fetchQuestions() async throws -> [Question] {
        guard let url = URL(string: baseURL) else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        do {
            let questionResponse = try JSONDecoder().decode(QuestionResponse.self, from: data)
            return questionResponse.questions
        } catch {
            throw APIError.decodingError
        }
    }
}

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
}
