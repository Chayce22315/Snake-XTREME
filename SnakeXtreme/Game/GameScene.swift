import SpriteKit

class GameScene: SKScene {
    var snake: Snake!
    var food: Food!
    var moveTimer: Timer?

    override func didMove(to view: SKView) {
        backgroundColor = .black

        // ✅ correct init
        snake = Snake(scene: self)

        spawnFood()

        moveTimer = Timer.scheduledTimer(
            timeInterval: 0.3,
            target: self,
            selector: #selector(updateSnake),
            userInfo: nil,
            repeats: true
        )
    }

    // MARK: - Food Spawning
    func spawnFood() {
        let cols = Int(size.width / Snake.blockSize)
        let rows = Int(size.height / Snake.blockSize)

        var emptyPositions: [CGPoint] = []

        for col in 0..<cols {
            for row in 0..<rows {
                let x = CGFloat(col) * Snake.blockSize + Snake.blockSize / 2
                let y = CGFloat(row) * Snake.blockSize + Snake.blockSize / 2
                let pos = CGPoint(x: x, y: y)

                if !snake.body.contains(where: { $0.position == pos }) {
                    emptyPositions.append(pos)
                }
            }
        }

        guard let position = emptyPositions.randomElement() else { return }

        food?.node.removeFromParent()
        food = Food()
        food.node.position = position
        addChild(food.node)
    }

    // MARK: - Game Loop
    @objc func updateSnake() {
        snake.move()

        if let headPos = snake.head?.position,
           headPos == food.node.position {
            snake.grow()
            spawnFood()
        }

        if snake.checkCollision(bounds: frame) {
            moveTimer?.invalidate()
            snake.die()
        }
    }

    // MARK: - Touch Controls
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first,
              let head = snake.head else { return }

        let location = touch.location(in: self)
        let dx = location.x - head.position.x
        let dy = location.y - head.position.y

        if abs(dx) > abs(dy) {
            snake.direction = CGVector(
                dx: dx > 0 ? Snake.blockSize : -Snake.blockSize,
                dy: 0
            )
        } else {
            snake.direction = CGVector(
                dx: 0,
                dy: dy > 0 ? Snake.blockSize : -Snake.blockSize
            )
        }
    }
}
