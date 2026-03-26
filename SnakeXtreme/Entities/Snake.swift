import SpriteKit

class Snake {

    var body: [SKShapeNode] = []
    var direction = CGVector(dx: 1, dy: 0)
    
    let blockSize: CGFloat = 20

    var head: SKShapeNode? {
        return body.first
    }

    init(scene: SKScene) {
        let start = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2)
        
        let head = SKShapeNode(rectOf: CGSize(width: blockSize, height: blockSize))
        head.fillColor = .green
        head.position = start
        
        body.append(head)
        scene.addChild(head)
    }

    func move() {
        guard let head = head else { return }

        let newPos = CGPoint(
            x: head.position.x + direction.dx * blockSize,
            y: head.position.y + direction.dy * blockSize
        )

        var prev = newPos

        for segment in body {
            let temp = segment.position
            segment.position = prev
            prev = temp
        }
    }

    func grow() {
        guard let tail = body.last else { return }
        
        let newSegment = SKShapeNode(rectOf: CGSize(width: blockSize, height: blockSize))
        newSegment.fillColor = .green
        newSegment.position = tail.position
        
        body.append(newSegment)
        tail.parent?.addChild(newSegment)
    }

    func consume(food: Food) {
        grow()
    }

    func collide(with obstacle: SKNode) {
        // you can expand later (damage, etc.)
    }

    func checkCollision(bounds: CGRect) -> Bool {
        guard let head = head else { return false }

        // wall
        if !bounds.contains(head.position) {
            return true
        }

        // self
        for segment in body.dropFirst() {
            if segment.position == head.position {
                return true
            }
        }

        return false
    }

    func reset(in scene: SKScene) {
        for part in body {
            part.removeFromParent()
        }
        body.removeAll()
        
        let start = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2)
        
        let head = SKShapeNode(rectOf: CGSize(width: blockSize, height: blockSize))
        head.fillColor = .green
        head.position = start
        
        body.append(head)
        scene.addChild(head)
        
        direction = CGVector(dx: 1, dy: 0)
    }
}
