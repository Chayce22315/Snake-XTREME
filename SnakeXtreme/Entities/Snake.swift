import SpriteKit

class Snake {
    static let blockSize: CGFloat = 32
    
    var body: [SKShapeNode] = []
    var scene: SKScene?
    var direction = CGVector(dx: 32, dy: 0)

    var head: SKShapeNode? {
        return body.first
    }

    init(scene: SKScene) {
        self.scene = scene

        let head = SKShapeNode(rectOf: CGSize(width: 28, height: 28))
        head.fillColor = .green
        head.position = CGPoint(x: 160, y: 160)

        body.append(head)
        scene.addChild(head)
    }

    func move() {
        guard let head = head else { return }

        let newPosition = CGPoint(
            x: head.position.x + direction.dx,
            y: head.position.y + direction.dy
        )

        let previousPositions = body.map { $0.position }

        body[0].position = newPosition

        for i in 1..<body.count {
            body[i].position = previousPositions[i - 1]
        }
    }

    func grow() {
        guard let last = body.last else { return }

        let newSegment = SKShapeNode(rectOf: CGSize(width: 28, height: 28))
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

    func checkCollision(bounds: CGRect) -> Bool {
        guard let head = head else { return false }

        // wall collision
        if !bounds.contains(head.position) {
            return true
        }

        // self collision
        for segment in body.dropFirst() {
            if head.position == segment.position {
                return true
            }
        }

        return false
    }
}
