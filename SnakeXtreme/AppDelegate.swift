import UIKit
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // MARK: - UIApplicationDelegate
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        // create window manually since we might not have a SceneDelegate
        let window = UIWindow(frame: UIScreen.main.bounds)

        // your main game view controller
        let rootViewController = GameViewController()
        window.rootViewController = rootViewController
        self.window = window
        window.makeKeyAndVisible()

        return true
    }
}
