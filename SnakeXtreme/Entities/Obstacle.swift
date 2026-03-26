import SpriteKit

class Obstacle {
    var node: SKShapeNode

    init(position: CGPoint) {
        node = SKShapeNode(rectOf: CGSize(width: 30, height: 30))
        node.fillColor = .gray
        node.position = position
    }
}
