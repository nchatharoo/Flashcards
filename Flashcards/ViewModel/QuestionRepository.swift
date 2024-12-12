protocol QuestionRepository {  
    func fetchQuestions() async throws -> [Question]
}

class RemoteQuestionRepository: QuestionRepository {
    
    private let service: APIServiceProtocol
    
    init(service: APIServiceProtocol) {
        self.service = service
    }
    
    func fetchQuestions() async throws -> [Question] {
        return try await service.fetchQuestions()
    }
}
