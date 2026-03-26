import SpriteKit
import Foundation

class CollisionSystem {

    var snake: Snake
    var food: Food
    var obstacles: [Obstacle]

    init(snake: Snake, food: Food, obstacles: [Obstacle] = []) {
        self.snake = snake
        self.food = food
        self.obstacles = obstacles
    }

    // call this every frame
    func update() {
        checkFoodCollision()
        checkObstacleCollisions()
    }

    // MARK: - Food Collision
    private func checkFoodCollision() {
        guard let snakeHead = snake.head else { return }
        guard let foodNode = food.node else { return }

        if snakeHead.frame.intersects(foodNode.frame) {
            snake.eat(food: food)
        }
    }

    // MARK: - Obstacle Collision
    private func checkObstacleCollisions() {
        guard let snakeHead = snake.head else { return }

        for obstacle in obstacles {
            guard let obstacleNode = obstacle.node else { continue }

            if snakeHead.frame.intersects(obstacleNode.frame) {
                snake.hitObstacle(obstacle)
            }
        }
    }
}
