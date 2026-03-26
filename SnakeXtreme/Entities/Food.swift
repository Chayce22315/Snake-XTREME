import SpriteKit

class Food: SKShapeNode {

    init(position: CGPoint) {
        super.init()
        
        self.path = CGPath(rect: CGRect(x: -10, y: -10, width: 20, height: 20), transform: nil)
        self.fillColor = .red
        self.strokeColor = .clear
        self.position = position
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func respawn(in scene: SKScene, avoiding snakeBody: [SKShapeNode]) {
        let blockSize: CGFloat = 20
        
        let cols = Int(scene.size.width / blockSize)
        let rows = Int(scene.size.height / blockSize)

        var empty: [CGPoint] = []

        for col in 0..<cols {
            for row in 0..<rows {
                let pos = CGPoint(
                    x: CGFloat(col) * blockSize + blockSize/2,
                    y: CGFloat(row) * blockSize + blockSize/2
                )
                
                if !snakeBody.contains(where: { $0.position == pos }) {
                    empty.append(pos)
                }
            }
        }

        if let newPos = empty.randomElement() {
            self.position = newPos
        }
    }
}
