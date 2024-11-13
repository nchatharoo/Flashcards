import Testing
import Foundation
@testable import Flashcards

@MainActor
final class QuestionViewModelTests {
    
    @Test func test_init_startsWithEmptyState() {
        let sut = makeSUT()
        
        #expect(sut.questions.isEmpty)
        #expect(sut.currentIndex == 0)
        #expect(sut.isLoading == false)
        #expect(sut.error == nil)
        #expect(sut.selectedAnswers.isEmpty)
        #expect(sut.answeredQuestions.isEmpty)
        #expect(sut.currentQuestion == nil)
    }
    
    @Test func test_loadQuestions_deliversQuestionsOnSuccess() async throws {
        let questions = makeQuestions()
        let service = MockAPIService(result: .success(questions))
        let sut = QuestionViewModel(service: service)

        await sut.loadQuestions()
        
        #expect(sut.questions == questions)
        #expect(sut.isLoading == false)
        #expect(sut.error == nil)
    }
    
    @Test func test_loadQuestions_deliversErrorOnFailure() async throws {
        let error = NSError(domain: "test", code: 0)
        let service = MockAPIService(result: .failure(error))
        let sut = QuestionViewModel(service: service)

        await sut.loadQuestions()
        
        #expect(sut.questions.isEmpty)
        #expect(sut.isLoading == false)
        #expect(sut.error as NSError? == error)
    }
    
    @Test func test_nextQuestion_incrementsIndexWithinBounds() {
        let sut = makeSUT()
        sut.questions = makeQuestions()
        
        sut.nextQuestion()
        #expect(sut.currentIndex == 1)
        
        sut.nextQuestion()
        #expect(sut.currentIndex == 1)
    }
    
    @Test func test_previousQuestion_decrementsIndexWithinBounds() {
        let sut = makeSUT()
        sut.questions = makeQuestions()
        sut.currentIndex = 1
        
        sut.previousQuestion()
        #expect(sut.currentIndex == 0)
        
        sut.previousQuestion()
        #expect(sut.currentIndex == 0)
    }
    
    @Test func test_selectAnswer_updatesStateCorrectly() {
        let sut = makeSUT()
        sut.questions = makeQuestions()
        let questionId = "1"
        let answerIndex = 1
        
        sut.selectAnswer(for: questionId, answerIndex: answerIndex)
        
        #expect(sut.selectedAnswers[questionId] == answerIndex)
        #expect(sut.answeredQuestions.contains(questionId))
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> QuestionViewModel {
        return QuestionViewModel()
    }
    
    private func makeQuestions() -> [Question] {
        return [
            Question(
                id: "1",
                question: "Quelle est la complexité temporelle moyenne d'un QuickSort ?",
                options: ["O(n)", "O(n log n)", "O(n²)", "O(log n)"],
                correctAnswer: 1,
                explanation: "QuickSort a une complexité moyenne de O(n log n)",
                category: .sorting
            ),
            Question(
                id: "2",
                question: "Qu'est-ce qu'une liste chaînée?",
                options: ["Un tableau", "Une structure avec des noeuds", "Un arbre", "Un graphe"],
                correctAnswer: 1,
                explanation: "Une liste chaînée est une séquence de noeuds",
                category: .linkedLists
            )
        ]
    }
}

// MARK: - Mocks

class MockAPIService: APIServiceProtocol {
    private let result: Result<[Question], Error>
    
    init(result: Result<[Question], Error>) {
        self.result = result
    }
    
    func fetchQuestions() async throws -> [Question] {
        switch result {
        case .success(let questions):
            return questions
        case .failure(let error):
            throw error
        }
    }
} 
