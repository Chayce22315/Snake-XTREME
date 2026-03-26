import SpriteKit

class Food: SKShapeNode {
    static let blockSize: CGFloat = 64

    init(position: CGPoint) {
        super.init()
        self.position = position
        self.path = CGPath(rect: CGRect(x: 0, y: 0, width: Food.blockSize, height: Food.blockSize), transform: nil)
        self.fillColor = .red
        self.strokeColor = .clear
        self.zPosition = 1
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) not implemented") }
}
