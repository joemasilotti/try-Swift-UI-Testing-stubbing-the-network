import SwiftUI

struct PlayersText: View {
    var minimum: Int
    var maximum: Int

    var body: some View {
        if minimum == maximum {
            return Text("\(minimum) players")
        } else {
            return Text("\(minimum) - \(maximum) players")
        }
    }
}

struct PlayersText_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlayersText(minimum: 1, maximum: 4)
            PlayersText(minimum: 2, maximum: 2)
        }
        .previewLayout(.fixed(width: 250, height: 40))
    }
}
