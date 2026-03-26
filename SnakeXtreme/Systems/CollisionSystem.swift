import SpriteKit

class CollisionSystem {
    let snake: Snake
    let food: Food
    let obstacles: [Obstacle]

    init(snake: Snake, food: Food, obstacles: [Obstacle]) {
        self.snake = snake
        self.food = food
        self.obstacles = obstacles
    }

    func checkCollisions() {
        guard let head = snake.head else { return }

        // FOOD COLLISION
        if head.frame.intersects(food.node.frame) {
            snake.grow()
            food.respawn()
        }

        // OBSTACLE COLLISION
        for obstacle in obstacles {
            if head.frame.intersects(obstacle.node.frame) {
                snake.die()
            }
        }

        // SELF COLLISION
        for segment in snake.body.dropFirst() {
            if head.frame.intersects(segment.frame) {
                snake.die()
            }
        }
    }
}
