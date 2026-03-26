import SpriteKit

class TrailSystem {

    var trailNodes: [SKShapeNode] = []
    let maxTrailLength: Int
    let blockSize: CGFloat

    init(maxTrailLength: Int = 20, blockSize: CGFloat = 64) {
        self.maxTrailLength = maxTrailLength
        self.blockSize = blockSize
    }

    func updateTrail(snakeHead: SKShapeNode, parent: SKNode) {
        let trailNode = SKShapeNode(circleOfRadius: blockSize/4)
        trailNode.fillColor = .green
        trailNode.strokeColor = .clear
        trailNode.position = snakeHead.position
        trailNode.zPosition = 0
        parent.addChild(trailNode)
        trailNodes.append(trailNode)

        if trailNodes.count > maxTrailLength {
            trailNodes.first?.removeFromParent()
            trailNodes.removeFirst()
        }
    }

    func setTrailColor(_ color: SKColor) {
        for node in trailNodes {
            node.fillColor = color
        }
    }
}
