import SpriteKit

class Snake {
    var body: [SKShapeNode] = []
    static let blockSize: CGFloat = 64
    var direction: CGVector = CGVector(dx: 1, dy: 0)

    init(startPosition: CGPoint, length: Int = 3) {
        for i in 0..<length {
            let segment = SKShapeNode(rectOf: CGSize(width: Snake.blockSize, height: Snake.blockSize))
            segment.fillColor = .green
            segment.strokeColor = .clear
            segment.position = CGPoint(x: startPosition.x - CGFloat(i) * Snake.blockSize, y: startPosition.y)
            segment.zPosition = 1
            body.append(segment)
        }
    }

    func move() {
        guard let head = body.first else { return }
        let newHead = SKShapeNode(rectOf: CGSize(width: Snake.blockSize, height: Snake.blockSize))
        newHead.fillColor = .green
        newHead.strokeColor = .clear
        newHead.position = CGPoint(x: head.position.x + direction.dx * Snake.blockSize,
                                   y: head.position.y + direction.dy * Snake.blockSize)
        newHead.zPosition = 1
        body.insert(newHead, at: 0)
        body.last?.removeFromParent()
        body.removeLast()
    }

    func grow() {
        guard let tail = body.last else { return }
        let newSegment = SKShapeNode(rectOf: CGSize(width: Snake.blockSize, height: Snake.blockSize))
        newSegment.fillColor = .green
        newSegment.strokeColor = .clear
        newSegment.position = tail.position
        newSegment.zPosition = 1
        body.append(newSegment)
    }

    func checkCollision(bounds: CGRect) -> Bool {
        guard let head = body.first else { return false }
        // wall collision
        if !bounds.contains(head.position) { return true }
        // self collision
        for segment in body.dropFirst() {
            if segment.position == head.position { return true }
        }
        return false
    }
}
