import Foundation

protocol AnswerRepository {
    func saveAnswers(selectedAnswers: [String: Int], answeredQuestions: Set<String>) async
    func loadAnswers() async -> (selectedAnswers: [String: Int], answeredQuestions: Set<String>)
    func clearAnswers() async
}

class LocalStorage {
    static let shared = LocalStorage()
    private let defaults = UserDefaults.standard
    
    private let selectedAnswersKey = "selectedAnswers"
    private let answeredQuestionsKey = "answeredQuestions"
    
    private init() {}
    
    func saveAnswers(selectedAnswers: [String: Int], answeredQuestions: Set<String>) {
        defaults.set(selectedAnswers, forKey: selectedAnswersKey)
        defaults.set(Array(answeredQuestions), forKey: answeredQuestionsKey)
    }
    
    func loadAnswers() -> (selectedAnswers: [String: Int], answeredQuestions: Set<String>) {
        let selectedAnswers = defaults.object(forKey: selectedAnswersKey) as? [String: Int] ?? [:]
        let answeredQuestions = Set(defaults.object(forKey: answeredQuestionsKey) as? [String] ?? [])
        return (selectedAnswers, answeredQuestions)
    }
    
    func clearAnswers() {
        defaults.removeObject(forKey: selectedAnswersKey)
        defaults.removeObject(forKey: answeredQuestionsKey)
    }
}

class LocalAnswerRepository: AnswerRepository {
    private let storage: LocalStorage
    
    init(storage: LocalStorage) {
        self.storage = storage
    }
    
    func saveAnswers(selectedAnswers: [String: Int], answeredQuestions: Set<String>) async {
        await storage.saveAnswers(selectedAnswers: selectedAnswers, answeredQuestions: answeredQuestions)
    }
    
    func loadAnswers() async -> (selectedAnswers: [String: Int], answeredQuestions: Set<String>) {
        await storage.loadAnswers()
    }
    
    func clearAnswers() async {
        await storage.clearAnswers()
    }
}
