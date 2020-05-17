import Foundation

typealias HTTPCompletion = (Data?) -> Void

struct HTTPClient {
    private let session = URLSession.shared
    private let baseURL: URL = {
        if let baseURL = ProcessInfo.processInfo.environment["base-url"] {
            return URL(string: baseURL)!
        } else {
            return URL(string: "https://masilotti.com")!
        }
    }()

    func get(_ path: String, completion: HTTPCompletion?) {
        let url = baseURL.appendingPathComponent(path)
        session.dataTask(with: url) { (data, response, error) in
            if let error = error { print(error) }
            DispatchQueue.main.async { completion?(data) }
        }.resume()
    }
}
