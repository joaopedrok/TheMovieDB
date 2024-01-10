import Foundation

protocol QueueAsyncExecutor {
    func execute(_ work: @escaping () -> Void)
}

struct MainThreadExecutor: QueueAsyncExecutor {
    func execute(_ work: @escaping () -> Void) {
        DispatchQueue.main.async {
            work()
        }
    }
}
