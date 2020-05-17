import Foundation

typealias HTTPCompletion = (Data?) -> Void

struct HTTPClient {
    private let baseURL = URL(string: "https://masilotti.com")!
    private let session = URLSession.shared

    func get(_ path: String, completion: HTTPCompletion?) {
        let url = baseURL.appendingPathComponent(path)
        session.dataTask(with: url) { (data, response, error) in
            if let error = error { print(error) }
            DispatchQueue.main.async { completion?(data) }
        }.resume()
    }
}
