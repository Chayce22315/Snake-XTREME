import SpriteKit

enum Direction {
    case up, down, left, right
}

class GameScene: SKScene {

    // MARK: - Core
    var snake: [SKShapeNode] = []
    var direction: Direction = .right
    var food: SKShapeNode!

    var lastUpdateTime: TimeInterval = 0
    var moveInterval: TimeInterval = 0.15

    var isDead = false

    // MARK: - UI
    var score = 0
    var scoreLabel: SKLabelNode!
    var retryLabel: SKLabelNode!

    // MARK: - Camera
    let cam = SKCameraNode()

    override func didMove(to view: SKView) {
        backgroundColor = .black

        camera = cam
        addChild(cam)

        createSnake()
        spawnFood()
        setupControls()
        setupUI()
    }

    // MARK: - Snake

    func createSegment() -> SKShapeNode {
        let node = SKShapeNode(rectOf: CGSize(width: 20, height: 20), cornerRadius: 6)
        node.fillColor = .systemGreen
        node.strokeColor = .clear
        node.glowWidth = 4
        return node
    }

    func createSnake() {
        for i in 0..<5 {
            let segment = createSegment()
            segment.position = CGPoint(x: CGFloat(i * 22), y: 0)
            addChild(segment)
            snake.append(segment)
        }
    }

    func moveSnake() {
        if isDead { return }

        var prev = snake[0].position

        for i in 1..<snake.count {
            let temp = snake[i].position
            snake[i].position = prev
            prev = temp
        }

        switch direction {
        case .up: snake[0].position.y += 22
        case .down: snake[0].position.y -= 22
        case .left: snake[0].position.x -= 22
        case .right: snake[0].position.x += 22
        }

        spawnTrail(at: snake[0].position)
        checkCollision()
        moveCamera()
    }

    func growSnake() {
        let segment = createSegment()
        segment.position = snake.last!.position
        addChild(segment)
        snake.append(segment)
    }

    // MARK: - Food

    func spawnFood() {
        food?.removeFromParent()

        food = SKShapeNode(circleOfRadius: 10)
        food.fillColor = .systemRed
        food.glowWidth = 6

        let x = CGFloat.random(in: -size.width/2...size.width/2)
        let y = CGFloat.random(in: -size.height/2...size.height/2)

        food.position = CGPoint(x: x, y: y)
        addChild(food)
    }

    // MARK: - Collision

    func checkCollision() {
        // food
        if snake[0].frame.intersects(food.frame) {
            growSnake()
            spawnFood()
            increaseSpeed()
            score += 1
            updateScore()
        }

        // self collision
        for i in 1..<snake.count {
            if snake[0].frame.intersects(snake[i].frame) {
                die()
            }
        }

        // wall collision
        if abs(snake[0].position.x) > size.width/2 ||
           abs(snake[0].position.y) > size.height/2 {
            die()
        }
    }

    func die() {
        if isDead { return }
        isDead = true

        GameCenterManager.shared.submitScore(score)

        screenShake()
        showRetry()
    }

    // MARK: - Speed

    func increaseSpeed() {
        moveInterval = max(0.05, moveInterval - 0.005)
    }

    // MARK: - UI

    func setupUI() {
        scoreLabel = SKLabelNode(text: "0")
        scoreLabel.fontSize = 30
        scoreLabel.position = CGPoint(x: 0, y: size.height/2 - 80)
        scoreLabel.zPosition = 200
        cam.addChild(scoreLabel)
    }

    func updateScore() {
        scoreLabel.text = "\(score)"
    }

    func showRetry() {
        retryLabel = SKLabelNode(text: "RETRY")
        retryLabel.name = "retry"
        retryLabel.fontSize = 40
        retryLabel.position = CGPoint(x: 0, y: 0)
        retryLabel.zPosition = 200
        cam.addChild(retryLabel)
    }

    func resetGame() {
        removeAllChildren()
        snake.removeAll()

        isDead = false
        score = 0
        moveInterval = 0.15

        addChild(cam)

        createSnake()
        spawnFood()
        setupControls()
        setupUI()
    }

    // MARK: - Controls

    func setupControls() {
        let dirs = ["up","down","left","right"]
        let pos: [CGPoint] = [
            CGPoint(x: 0, y: -200),
            CGPoint(x: 0, y: -300),
            CGPoint(x: -100, y: -250),
            CGPoint(x: 100, y: -250)
        ]

        for (i, d) in dirs.enumerated() {
            let btn = SKLabelNode(text: d.uppercased())
            btn.name = d
            btn.fontSize = 20
            btn.zPosition = 200
            btn.position = pos[i]
            cam.addChild(btn)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let node = atPoint(touch.location(in: self))

        if node.name == "retry" {
            resetGame()
            return
        }

        switch node.name {
        case "up": if direction != .down { direction = .up }
        case "down": if direction != .up { direction = .down }
        case "left": if direction != .right { direction = .left }
        case "right": if direction != .left { direction = .right }
        default: break
        }
    }

    // MARK: - Camera

    func moveCamera() {
        cam.position = snake[0].position
    }

    // MARK: - Effects

    func spawnTrail(at pos: CGPoint) {
        let trail = SKShapeNode(circleOfRadius: 5)
        trail.position = pos
        trail.fillColor = .systemGreen
        trail.alpha = 0.5
        trail.zPosition = -1
        addChild(trail)

        trail.run(.sequence([
            .fadeOut(withDuration: 0.3),
            .removeFromParent()
        ]))
    }

    func screenShake() {
        let shake = SKAction.sequence([
            .moveBy(x: 10, y: 0, duration: 0.05),
            .moveBy(x: -20, y: 0, duration: 0.05),
            .moveBy(x: 10, y: 0, duration: 0.05)
        ])
        cam.run(shake)
    }

    // MARK: - Game Loop

    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTime == 0 {
            lastUpdateTime = currentTime
        }

        let delta = currentTime - lastUpdateTime

        if delta >= moveInterval {
            moveSnake()
            lastUpdateTime = currentTime
        }
    }
}
