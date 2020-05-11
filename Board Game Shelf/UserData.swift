import Foundation

class UserData: ObservableObject {
    @Published var ids: [Int] = []
    @Published var boardGames: [Int : BoardGame] = [:]

    func fetchGames() {
        self.ids = boardGameData
            .sorted(by: { $0.name < $1.name })
            .map { $0.id }
        self.boardGames = boardGameData
            .reduce(into: [:], { $0[$1.id] = $1 })
    }
}
