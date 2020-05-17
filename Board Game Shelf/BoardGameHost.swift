import SwiftUI

struct BoardGameHost: View {
    @EnvironmentObject var userData: UserData
    @Environment(\.editMode) var mode
    @Binding var boardGame: BoardGame
    @State var draftBoardGame = BoardGame.default
    @State var showingAlert = false

    var cancelButton: some View {
        Button("Cancel") { self.showingAlert = true }
    }

    var discardChangesButton: Alert.Button {
        Alert.Button.destructive(Text("Discard changes"), action: {
            self.draftBoardGame = self.userData.boardGames[unchecked: self.boardGame.id]
            self.mode?.animation().wrappedValue = .inactive
        })
    }

    var body: some View {
        VStack {
            if mode?.wrappedValue == .active {
                BoardGameEditor(boardGame: $draftBoardGame)
                    .onAppear { self.draftBoardGame = self.boardGame }
                    .onDisappear { self.boardGame = self.draftBoardGame }
            } else {
                BoardGameSummary(boardGame: boardGame)
            }
        }
        .navigationBarTitle(Text(boardGame.name), displayMode: .inline)
        .navigationBarBackButtonHidden(mode?.wrappedValue == .active)
        .navigationBarItems(
            leading: mode?.wrappedValue == .active ? cancelButton : nil,
            trailing: EditButton()
        )
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Discard changes?"),
                    primaryButton: .default(Text("Keep editing")),
                    secondaryButton: discardChangesButton
                )
        }
    }
}

struct BoardGameHost_Previews: PreviewProvider {
    static var previews: some View {
        BoardGameHost(boardGame: .constant(BoardGame.preview))
    }
}
