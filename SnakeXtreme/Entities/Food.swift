import SpriteKit

class Food {
    var node: SKShapeNode

    init() {
        node = SKShapeNode(circleOfRadius: 10)
        node.fillColor = .red
        node.position = CGPoint(x: 200, y: 200)
    }

    func respawn() {
        node.position = CGPoint(
            x: CGFloat.random(in: 20...380),
            y: CGFloat.random(in: 20...780)
        )
    }
}
