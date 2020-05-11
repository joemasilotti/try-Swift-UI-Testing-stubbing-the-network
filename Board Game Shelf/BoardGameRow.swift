import SwiftUI

struct BoardGameRow: View {
    var boardGame: BoardGame

    var body: some View {
        VStack {
            boardGame.image
                .renderingMode(.original)
                .resizable()
                .scaledToFill()
                .frame(height: 200, alignment: .top)
                .clipped()
                .overlay(ImageOverlay(text: boardGame.name), alignment: .bottomLeading)
        }
    }
}

struct ImageOverlay: View {
    var text: String

    var body: some View {
        HStack {
            Text(text)
                .font(.headline)
                .padding(10)
                .foregroundColor(.white)
            Spacer()
        }
        .background(Color.black)
        .opacity(0.7)
    }
}

struct BoardGameRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BoardGameRow(boardGame: boardGameData[0])
            BoardGameRow(boardGame: boardGameData[1])
            BoardGameRow(boardGame: boardGameData[2])
        }
        .previewLayout(.fixed(width: 300, height: 200))
    }
}
