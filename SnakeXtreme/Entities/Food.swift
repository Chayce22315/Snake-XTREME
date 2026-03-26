class Food {
    let node: SKSpriteNode

    init(position: CGPoint) {
        node = SKSpriteNode(color: .red, size: CGSize(width: 10, height: 10))
        node.position = position
    }
}
