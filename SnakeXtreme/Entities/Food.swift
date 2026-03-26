import SpriteKit

class Food {
    var node: SKShapeNode
    
    init(position: CGPoint, radius: CGFloat = 10) {
        node = SKShapeNode(circleOfRadius: radius)
        node.fillColor = .gray
        node.position = position
    }
}
