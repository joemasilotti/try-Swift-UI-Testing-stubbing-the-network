import Foundation

class UserData: ObservableObject {
    @Published var ids: [Int] = []
    @Published var boardGames: [Int : BoardGame] = [:]

    private let client: HTTPClientable

    init(client: HTTPClientable = HTTPClient()) {
        self.client = client
    }

    func fetchGames() {
        self.client.get("boardgames.json") { data in
            guard
                let data = data,
                let boardGames = try? JSONDecoder().decode([BoardGame].self, from: data)
                else { return }

            self.ids = boardGames
                .sorted(by: { $0.name < $1.name })
                .map { $0.id }
            self.boardGames = boardGames
                .reduce(into: [:], { $0[$1.id] = $1 })
        }
    }
}
