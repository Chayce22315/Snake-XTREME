import SpriteKit

class GameScene: SKScene {

    var snake: Snake!
    var food: Food!
    var moveTimer: Timer?

    var score = 0
    var scoreLabel: SKLabelNode!
    var retryLabel: SKLabelNode!

    override func didMove(to view: SKView) {
        backgroundColor = .black
        
        snake = Snake(scene: self)

        food = Food(position: CGPoint(x: size.width/2, y: size.height/2))
        addChild(food)
        food.respawn(in: self, avoiding: snake.body)

        setupUI()

        moveTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(updateGame), userInfo: nil, repeats: true)
    }

    func setupUI() {
        scoreLabel = SKLabelNode(text: "score: 0")
        scoreLabel.position = CGPoint(x: 0, y: size.height/2 - 50)
        scoreLabel.fontSize = 24
        addChild(scoreLabel)

        retryLabel = SKLabelNode(text: "retry")
        retryLabel.position = CGPoint(x: 0, y: 0)
        retryLabel.fontSize = 40
        retryLabel.isHidden = true
        retryLabel.name = "retry"
        addChild(retryLabel)
    }

    @objc func updateGame() {
        snake.move()

        if let head = snake.head {
            if head.frame.intersects(food.frame) {
                snake.consume(food: food)
                score += 1
                scoreLabel.text = "score: \(score)"
                food.respawn(in: self, avoiding: snake.body)
            }
        }

        if snake.checkCollision(bounds: frame) {
            gameOver()
        }
    }

    func gameOver() {
        moveTimer?.invalidate()
        retryLabel.isHidden = false
    }

    func restart() {
        score = 0
        scoreLabel.text = "score: 0"
        
        retryLabel.isHidden = true
        
        snake.reset(in: self)
        food.respawn(in: self, avoiding: snake.body)
        
        moveTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(updateGame), userInfo: nil, repeats: true)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)

        if let node = nodes(at: location).first, node.name == "retry" {
            restart()
            return
        }

        guard let head = snake.head else { return }

        let dx = location.x - head.position.x
        let dy = location.y - head.position.y

        if abs(dx) > abs(dy) {
            snake.direction = CGVector(dx: dx > 0 ? 1 : -1, dy: 0)
        } else {
            snake.direction = CGVector(dx: 0, dy: dy > 0 ? 1 : -1)
        }
    }
}
