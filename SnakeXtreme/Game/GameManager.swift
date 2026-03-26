import SpriteKit

class GameManager {
    var snake: Snake
    var food: Food
    var obstacles: [Obstacle] = []
    
    init(snake: Snake, food: Food) {
        self.snake = snake
        self.food = food
    }
    
    func update() {
        checkFoodCollision()
    }
    
    private func checkFoodCollision() {
        if snake.head?.frame.intersects(food.node.frame) == true {
            // collision logic if needed
        }
    }
}
