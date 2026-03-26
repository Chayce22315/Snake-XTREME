import SpriteKit

class Obstacle {
    var node: SKShapeNode
    
    init(position: CGPoint, size: CGSize) {
        node = SKShapeNode(rectOf: size)
        node.fillColor = .gray
        node.position = position
    }
}
