import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let scene = GameScene(size: view.bounds.size)
        let skView = SKView(frame: view.bounds)
        skView.presentScene(scene)
        skView.ignoresSiblingOrder = true

        view.addSubview(skView)
    }
}
