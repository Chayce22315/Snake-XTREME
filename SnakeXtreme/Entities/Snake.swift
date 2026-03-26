import SpriteKit

class Snake {
    var body: [SKShapeNode] = []
    var scene: SKScene?

    var head: SKShapeNode? {
        return body.first
    }

    init(scene: SKScene) {
        self.scene = scene

        let head = SKShapeNode(rectOf: CGSize(width: 20, height: 20))
        head.fillColor = .green
        head.position = CGPoint(x: 100, y: 100)

        body.append(head)
        scene.addChild(head)
    }

    func move(by direction: CGVector) {
        guard let head = head else { return }

        let newPosition = CGPoint(
            x: head.position.x + direction.dx,
            y: head.position.y + direction.dy
        )

        var previousPositions: [CGPoint] = body.map { $0.position }

        body[0].position = newPosition

        for i in 1..<body.count {
            body[i].position = previousPositions[i - 1]
        }
    }

    func grow() {
        guard let last = body.last else { return }

        let newSegment = SKShapeNode(rectOf: CGSize(width: 20, height: 20))
        newSegment.fillColor = .green
        newSegment.position = last.position

        body.append(newSegment)
        scene?.addChild(newSegment)
    }

    func die() {
        print("snake died")

        for segment in body {
            segment.removeFromParent()
        }

        body.removeAll()
    }
}
