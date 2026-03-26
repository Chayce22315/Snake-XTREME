import SpriteKit

class GameScene: SKScene {
    let snake = Snake(startPosition: CGPoint(x: 512, y: 512))
    var food: Food!
    var moveTimer: Timer?

    // MARK: - Scene Setup
    override func didMove(to view: SKView) {
        backgroundColor = .black
        
        // add snake segments
        for segment in snake.body {
            addChild(segment)
        }
        
        spawnFood()
        
        // movement timer
        moveTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(updateSnake), userInfo: nil, repeats: true)
    }

    // MARK: - Food Spawning
    func spawnFood() {
        let cols = Int(size.width / Snake.blockSize)
        let rows = Int(size.height / Snake.blockSize)

        var emptyPositions: [CGPoint] = []
        for col in 0..<cols {
            for row in 0..<rows {
                let pos = CGPoint(
                    x: CGFloat(col) * Snake.blockSize + Snake.blockSize/2,
                    y: CGFloat(row) * Snake.blockSize + Snake.blockSize/2
                )
                if !snake.body.contains(where: { $0.position == pos }) {
                    emptyPositions.append(pos)
                }
            }
        }

        guard let position = emptyPositions.randomElement() else { return }
        food?.removeFromParent()
        food = Food(position: position)
        addChild(food)
    }

    // MARK: - Snake Update
    @objc func updateSnake() {
        snake.move()
        
        // check food collision
        if let headPos = snake.head?.position, headPos == food.position {
            snake.grow()
            spawnFood()
        }
        
        // check wall/self collision
        if snake.checkCollision(bounds: frame) {
            moveTimer?.invalidate()
            // TODO: handle death/reset
        }
        
        // re-add segments if removed
        for segment in snake.body where segment.parent == nil {
            addChild(segment)
        }
    }

    // MARK: - Touch Controls
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let head = snake.head else { return }
        let location = touch.location(in: self)
        let dx = location.x - head.position.x
        let dy = location.y - head.position.y

        if abs(dx) > abs(dy) {
            snake.direction = CGVector(dx: dx > 0 ? 1 : -1, dy: 0)
        } else {
            snake.direction = CGVector(dx: 0, dy: dy > 0 ? 1 : -1)
        }
    }
}
