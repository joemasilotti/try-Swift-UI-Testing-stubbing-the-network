#if DEBUG
import Foundation

struct FakeHTTPClient: HTTPClientable {
    private let networkStubs: [NetworkStub]

    init() {
        let networkStubs = ProcessInfo.processInfo.environment["network-stubs"]!
        self.networkStubs = try! JSONDecoder()
            .decode([NetworkStub].self, from: networkStubs.data(using: .utf8)!)
    }

    func get(_ path: String, completion: HTTPCompletion?) {
        let response = networkStubs.first(where: { $0.path == path })!.response
        completion?(response)
    }
}

struct NetworkStub: Codable {
    var path: String
    var response: Data
}
#endif
