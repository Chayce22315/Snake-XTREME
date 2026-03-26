import SpriteKit

class CollisionSystem {

    func check(
        snake: Snake,
        food: Food,
        in scene: SKScene,
        scoreUpdate: () -> Void,
        gameOver: () -> Void
    ) {
        guard let head = snake.head else { return }

        // 🍎 FOOD COLLISION
        if head.frame.intersects(food.frame) {
            snake.grow()
            food.respawn(in: scene, avoiding: snake.body)
            scoreUpdate()
        }

        // 💀 WALL COLLISION
        if !scene.frame.contains(head.position) {
            gameOver()
        }

        // 🐍 SELF COLLISION
        for segment in snake.body.dropFirst() {
            if head.position == segment.position {
                gameOver()
            }
        }
    }
}
