import SpriteKit

class Obstacle {
    let node: SKSpriteNode

    init(position: CGPoint, size: CGSize, color: SKColor = .gray) {
        node = SKSpriteNode(color: color, size: size)
        node.position = position
    }

    func addToScene(_ scene: SKScene) {
        scene.addChild(node)
    }
}
