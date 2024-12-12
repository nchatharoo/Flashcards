import Foundation

@MainActor
class QuestionUseCases {
    private let questionRepository: QuestionRepository
    private let answerRepository: AnswerRepository
    
    init(questionRepository: QuestionRepository, answerRepository: AnswerRepository) {
        self.questionRepository = questionRepository
        self.answerRepository = answerRepository
    }
    
    func fetchQuestions() async throws -> [Question] {
        try await questionRepository.fetchQuestions()
    }
    
    func saveAnswer(selectedAnswers: [String: Int], answeredQuestions: Set<String>) async {
        await answerRepository.saveAnswers(selectedAnswers: selectedAnswers, answeredQuestions: answeredQuestions)
    }
    
    func loadSavedAnswers() async -> (selectedAnswers: [String: Int], answeredQuestions: Set<String>) {
        await answerRepository.loadAnswers()
    }
    
    func clearAnswers() async {
        await answerRepository.clearAnswers()
    }
}
