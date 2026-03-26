import SpriteKit

class GameManager {

    let scene: SKScene
    let snake: Snake
    let food: Food
    let collisionSystem = CollisionSystem()

    var score = 0
    var speed: CGFloat = 20
    var direction = CGVector(dx: 20, dy: 0)

    var scoreLabel: SKLabelNode!
    var retryButton: SKLabelNode!

    init(scene: SKScene) {
        self.scene = scene
        self.snake = Snake(startPos: CGPoint(x: scene.size.width/2, y: scene.size.height/2))
        self.food = Food(position: CGPoint(x: 100, y: 100))

        setupScene()
    }

    func setupScene() {
        // add snake to scene
        for segment in snake.body { scene.addChild(segment) }

        // add food
        scene.addChild(food)

        // score label
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.fontColor = .white
        scoreLabel.fontSize = 24
        scoreLabel.position = CGPoint(x: 80, y: scene.size.height - 50)
        scene.addChild(scoreLabel)

        // retry button (hidden initially)
        retryButton = SKLabelNode(text: "RETRY")
        retryButton.fontColor = .yellow
        retryButton.fontSize = 32
        retryButton.position = CGPoint(x: scene.size.width/2, y: scene.size.height/2)
        retryButton.isHidden = true
        scene.addChild(retryButton)
    }

    func update() {
        snake.move(direction: direction)
        collisionSystem.check(
            snake: snake,
            food: food,
            in: scene,
            scoreUpdate: { [weak self] in
                guard let self = self else { return }
                self.score += 1
                self.speed += 0.5
                self.scoreLabel.text = "Score: \(self.score)"
            },
            gameOver: { [weak self] in
                self?.endGame()
            }
        )
    }

    func endGame() {
        retryButton.isHidden = false
        direction = CGVector(dx: 0, dy: 0)
    }

    func retry() {
        // reset snake
        for segment in snake.body { segment.removeFromParent() }
        snake.body.removeAll()
        let newSnake = Snake(startPos: CGPoint(x: scene.size.width/2, y: scene.size.height/2))
        snake.body = newSnake.body
        for segment in snake.body { scene.addChild(segment) }

        // reset food
        food.respawn(in: scene, avoiding: snake.body)

        // reset score
        score = 0
        speed = 20
        scoreLabel.text = "Score: 0"

        retryButton.isHidden = true
    }
}
