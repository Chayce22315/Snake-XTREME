import SpriteKit

class Food: SKShapeNode {

    init(position: CGPoint) {
        super.init()
        let size: CGFloat = 20
        self.path = CGPath(rect: CGRect(x: -size/2, y: -size/2, width: size, height: size), transform: nil)
        self.fillColor = .red
        self.strokeColor = .clear
        self.position = position
        self.name = "food"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func respawn(in scene: SKScene, avoiding snakeBody: [SKShapeNode]) {
        let cols = Int(scene.size.width / 20)
        let rows = Int(scene.size.height / 20)

        var validPositions: [CGPoint] = []

        for col in 0..<cols {
            for row in 0..<rows {
                let pos = CGPoint(x: CGFloat(col) * 20 + 10,
                                  y: CGFloat(row) * 20 + 10)
                if !snakeBody.contains(where: { $0.position == pos }) {
                    validPositions.append(pos)
                }
            }
        }

        if let newPos = validPositions.randomElement() {
            self.position = newPos
        }
    }
}
