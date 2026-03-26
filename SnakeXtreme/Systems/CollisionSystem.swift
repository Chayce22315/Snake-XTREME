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

    func update() {
        checkFoodCollision()
        checkObstacleCollisions()
    }

    private func checkFoodCollision() {
        // optional chain because snake.head might be nil
        if let snakeHead = snake.head {
            if snakeHead.frame.intersects(food.node.frame) {
                // handle collision in snake/game manager
                snake.consume(food: food) // replace with your actual method
            }
        }
    }

    private func checkObstacleCollisions() {
        guard let snakeHead = snake.head else { return }

        for obstacle in obstacles {
            // directly use SKShapeNode, no 'guard let'
            if snakeHead.frame.intersects(obstacle.node.frame) {
                // handle collision in snake/game manager
                snake.collide(with: obstacle) // replace with your actual method
            }
        }
    }
}
