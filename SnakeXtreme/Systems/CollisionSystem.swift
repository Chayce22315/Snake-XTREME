import SpriteKit

class CollisionSystem {

    let snake: Snake
    let food: Food
    let obstacles: [Obstacle]
    let powerUps: [PowerUp]

    init(snake: Snake, food: Food, obstacles: [Obstacle], powerUps: [PowerUp]) {
        self.snake = snake
        self.food = food
        self.obstacles = obstacles
        self.powerUps = powerUps
    }

    func checkCollisions() {
        // snake & food
        if let head = snake.head, let foodNode = food.node, head.frame.intersects(foodNode.frame) {
            snake.eat(food: food)
            food.spawnNewFood()
        }

        // snake & obstacles
        for obstacle in obstacles {
            if let head = snake.head, let obstacleNode = obstacle.node, head.frame.intersects(obstacleNode.frame) {
                snake.hitObstacle(obstacle)
                // you can break here if snake dies on first hit
                break
            }
        }

        // snake & power-ups
        for powerUp in powerUps {
            if let head = snake.head, let powerNode = powerUp.node, head.frame.intersects(powerNode.frame) {
                snake.collect(powerUp: powerUp)
                powerUp.removeFromScene()
            }
        }

        // optional: snake colliding with itself
        if let head = snake.head {
            for segment in snake.body.dropFirst() { // skip head
                if let segmentNode = segment.node, head.frame.intersects(segmentNode.frame) {
                    snake.hitSelf()
                    break
                }
            }
        }
    }
}
