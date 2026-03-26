import SpriteKit

class GameScene: SKScene {

    var manager: GameManager!

    override func didMove(to view: SKView) {
        manager = GameManager(scene: self)
    }

    override func update(_ currentTime: TimeInterval) {
        manager.update()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let pos = touch.location(in: self)

        // simple 4-way touch control
        if pos.x < size.width/2 && abs(pos.x - size.width/2) > abs(pos.y - size.height/2) {
            manager.direction = CGVector(dx: -20, dy: 0)
        } else if pos.x > size.width/2 && abs(pos.x - size.width/2) > abs(pos.y - size.height/2) {
            manager.direction = CGVector(dx: 20, dy: 0)
        } else if pos.y > size.height/2 {
            manager.direction = CGVector(dx: 0, dy: 20)
        } else if pos.y < size.height/2 {
            manager.direction = CGVector(dx: 0, dy: -20)
        }

        // retry
        if manager.retryButton.contains(pos) && !manager.retryButton.isHidden {
            manager.retry()
        }
    }
}
