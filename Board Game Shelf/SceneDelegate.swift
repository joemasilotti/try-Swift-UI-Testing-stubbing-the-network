import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let boardGameList = BoardGameList()
            .environmentObject(UserData(client: client))

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: boardGameList)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    private var client: HTTPClientable { uiTesting ? fakeHTTPClient : HTTPClient() }
    private var uiTesting: Bool { ProcessInfo.processInfo.arguments.contains("ui-testing") }
    private var fakeHTTPClient: HTTPClientable {
        #if DEBUG
        return FakeHTTPClient()
        #else
        return HTTPClient()
        #endif
    }
}
