import SwiftUI

struct BoardGameList: View {
    @EnvironmentObject var userData: UserData

    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    ForEach(userData.ids, id: \.self) { id in
                        NavigationLink(
                            destination: BoardGameHost(boardGame: self.$userData.boardGames[unchecked: id])
                                .environmentObject(self.userData)
                        ) {
                            BoardGameRow(boardGame: self.userData.boardGames[unchecked: id])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .navigationBarTitle(Text("My Shelf"))
        }
        .onAppear(perform: {
            self.userData.fetchGames()
        })
    }
}

struct BoardGameList_Previews: PreviewProvider {
    static var previews: some View {
        BoardGameList()
            .environmentObject(UserData())
    }
}
