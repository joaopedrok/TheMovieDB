import Foundation

@testable import TheMovieDB

final class QueueAsyncExecutorSpy: QueueAsyncExecutor {       
    private(set) var executeCount = 0
    
    func execute(_ closure: @escaping () -> Void) {
        executeCount += 1
        closure()
    }
}
