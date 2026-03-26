import SpriteKit

class CollisionSystem {

    // checks if a given frame intersects with a Food instance
    static func intersects(frame: CGRect, food: Food) -> Bool {
        return frame.intersects(food.node.frame)
    }

    // optional: check collision between two obstacles
    static func intersects(obstacle1: Obstacle, obstacle2: Obstacle) -> Bool {
        return obstacle1.node.frame.intersects(obstacle2.node.frame)
    }
}
