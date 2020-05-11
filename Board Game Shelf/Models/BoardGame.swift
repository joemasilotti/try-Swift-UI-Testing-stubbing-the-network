import SwiftUI

struct BoardGame: Codable, Identifiable {
    var id: Int
    var name: String
    var minimumPlayers: Int = 1
    var maximumPlayers: Int
    var category: Category
    var description: String

    fileprivate var imageName: String

    static let `default` = Self(id: 0, name: "", minimumPlayers: 1, maximumPlayers: 1, category: .deckBuilding, description: "", imageName: "")

    enum Category: String, Codable, CaseIterable {
        case deckBuilding = "Deck building"
        case gridCoverage = "Grid coverage"
        case tilePlacement = "Tile placement"
        case trickTaking = "Trick taking"
    }
}

extension BoardGame {
    var image: Image {
        ImageStore.shared.image(name: imageName)
    }

    var gameplayImage: Image {
        ImageStore.shared.image(name: "\(imageName)-gameplay")
    }
}

extension Dictionary where Key == Int, Value == BoardGame {
    subscript(unchecked key: Key) -> Value {
        get {
            guard let result = self[key] else {
                fatalError("This board game does not exist.")
            }
            return result
        }
        set {
            self[key] = newValue
        }
    }
}
