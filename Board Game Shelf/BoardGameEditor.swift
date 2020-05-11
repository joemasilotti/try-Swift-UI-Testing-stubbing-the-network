import SwiftUI

struct BoardGameEditor: View {
    @EnvironmentObject var userData: UserData
    @Binding var boardGame: BoardGame

    init(boardGame: Binding<BoardGame>) {
        self._boardGame = boardGame
        UITextField.appearance().clearButtonMode = .whileEditing
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Name", text: $boardGame.name)
                }

                Section(header: Text("Players")) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Minimum")
                                .frame(maxHeight: .infinity)
                            Text("Maximum")
                                .frame(maxHeight: .infinity)
                        }

                        VStack {
                            HStack {
                                Slider(
                                    value: $boardGame.minimumPlayers.double,
                                    in: 1...10,
                                    step: 1,
                                    onEditingChanged: { _ in
                                        if self.boardGame.minimumPlayers > self.boardGame.maximumPlayers {
                                            self.boardGame.maximumPlayers = self.boardGame.minimumPlayers
                                        }
                                })
                                    .accessibility(label: Text("Minimum players"))
                                Text(String(boardGame.minimumPlayers))
                            }

                            HStack {
                                Slider(
                                    value: $boardGame.maximumPlayers.double,
                                    in: 1...10,
                                    step: 1,
                                    onEditingChanged: { _ in
                                        if self.boardGame.maximumPlayers < self.boardGame.minimumPlayers {
                                            self.boardGame.minimumPlayers = self.boardGame.maximumPlayers
                                        }
                                })
                                    .accessibility(label: Text("Maximum players"))
                                Text(String(boardGame.maximumPlayers))
                            }
                        }
                    }
                }

                Section(header: Text("Category")) {
                    Picker("Category", selection: $boardGame.category) {
                        ForEach(BoardGame.Category.allCases, id: \.self) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                    .labelsHidden()
                }

                Section(header: Text("Description")) {
                    TextView(text: $boardGame.description)
                        .frame(height: 200)
                }
            }
        }
            // "Hide" extra NavigationView to enable Picker navigation.
            .padding(.top, -1)
    }
}

struct BoardGameEditor_Previews: PreviewProvider {
    static var previews: some View {
        BoardGameEditor(boardGame: .constant(boardGameData[0]))
    }
}

extension Int {
    var double: Double {
        get { Double(self) }
        set { self = Int(newValue) }
    }
}
