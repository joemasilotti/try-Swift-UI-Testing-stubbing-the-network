import SwiftUI

struct BoardGameSummary: View {
    var boardGame: BoardGame
    @State var showingDetails = false

    var body: some View {
        ScrollView {
            VStack {
                boardGame.gameplayImage
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 300)
                    .edgesIgnoringSafeArea(.top)

                CircleImage(image: boardGame.image)
                    .offset(x: 0, y: -130)
                    .padding(.bottom, -130)

                VStack(alignment: .leading) {
                    HStack {
                        Text(boardGame.name)
                            .font(.title)
                    }

                    HStack {
                        Text(boardGame.category.rawValue)
                            .font(.subheadline)
                        Spacer()
                        PlayersText(
                            minimum: boardGame.minimumPlayers,
                            maximum: boardGame.maximumPlayers
                        )
                            .font(.subheadline)
                    }
                    .padding(.bottom)

                    Text(boardGame.description)
                }
                .padding()

                Button("More info") { self.showingDetails.toggle() }

                Spacer()
            }
        }
        .sheet(isPresented: $showingDetails) {
            BoardGameDetails(
                boardGame: self.boardGame,
                showingDetails: self.$showingDetails
            )
        }
    }
}

struct BoardGameSummary_Previews: PreviewProvider {
    static var previews: some View {
        BoardGameSummary(boardGame: BoardGame.preview)
    }
}
