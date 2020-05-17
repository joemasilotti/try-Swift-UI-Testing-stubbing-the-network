import SwiftUI
import WebKit

struct BoardGameDetails: View {
    var boardGame: BoardGame
    @Binding var showingDetails: Bool

    private var title: String { "\(boardGame.name) on Board Game Geek" }

    private var request: URLRequest {
        URLRequest(url: URL(string: "https://boardgamegeek.com/boardgame/\(boardGame.id)")!)
    }

    private var cancelButton: some View {
        Button(action: { self.showingDetails.toggle() }) {
            Text("Cancel")
        }
    }


    var body: some View {
        NavigationView {
            WebView(request: request)
                .navigationBarTitle(Text(title), displayMode: .inline)
                .navigationBarItems(trailing: cancelButton)
        }
    }
}

struct BoardGameDetails_Previews: PreviewProvider {
    static var previews: some View {
        BoardGameDetails(
            boardGame: BoardGame.preview,
            showingDetails: .constant(true)
        )
    }
}

struct WebView : UIViewRepresentable {
    let request: URLRequest

    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
}
