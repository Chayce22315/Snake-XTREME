import SpriteKit

class Snake {
    var body: [SKShapeNode] = []
    var head: SKShapeNode? { body.first }

    init(startPos: CGPoint) {
        let headNode = SKShapeNode(rectOf: CGSize(width: 20, height: 20))
        headNode.fillColor = .green
        headNode.position = startPos
        body.append(headNode)
    }

    func grow() {
        guard let last = body.last else { return }

        let newSegment = SKShapeNode(rectOf: last.frame.size)
        newSegment.fillColor = .green
        newSegment.position = last.position
        body.append(newSegment)
    }

    func move(direction: CGVector) {
        guard !body.isEmpty else { return }
        var prevPos = body.first!.position
        body.first!.position.x += direction.dx
        body.first!.position.y += direction.dy

        for segment in body.dropFirst() {
            let temp = segment.position
            segment.position = prevPos
            prevPos = temp
        }
    }
}
