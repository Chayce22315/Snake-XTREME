import SpriteKit

// MARK: - Snake

class Snake {
    var head: SKShapeNode?      // snake's head
    var body: [SKShapeNode] = [] // snake segments

    init(head: SKShapeNode?) {
        self.head = head
        if let h = head { body.append(h) }
    }

    func eat(food: Food) {
        // placeholder: logic when snake eats food
        print("snake ate food!")
    }

    func hitObstacle(_ obstacle: Obstacle) {
        // placeholder: logic when snake hits obstacle
        print("snake hit obstacle!")
    }

    func hitSelf() {
        // placeholder: logic when snake collides with itself
        print("snake hit itself!")
    }

    func collect(powerUp: PowerUp) {
        // placeholder: logic when snake collects a power-up
        print("snake collected a power-up!")
    }
}

// MARK: - Food

class Food {
    var node: SKShapeNode?

    init(node: SKShapeNode?) {
        self.node = node
    }

    func spawnNewFood() {
        // placeholder: spawn logic
        print("new food spawned")
    }
}

// MARK: - Obstacle

class Obstacle {
    var node: SKShapeNode?

    init(node: SKShapeNode?) {
        self.node = node
    }
}

// MARK: - PowerUp

class PowerUp {
    var node: SKShapeNode?

    init(node: SKShapeNode?) {
        self.node = node
    }

    func removeFromScene() {
        // placeholder: remove from parent node
        print("power-up removed")
    }
}
