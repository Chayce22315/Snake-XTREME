import SpriteKit

class Food {
    var node: SKShapeNode

    init() {
        node = SKShapeNode(circleOfRadius: 10)
        node.fillColor = .red
    }
}
