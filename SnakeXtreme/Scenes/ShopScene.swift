import SpriteKit

class ShopScene: SKScene {

    override func didMove(to view: SKView) {
        backgroundColor = .darkGray
        
        // MARK: - Title
        let title = SKLabelNode(text: "SHOP")
        title.fontName = "Chalkduster"
        title.fontSize = 120
        title.fontColor = .white
        title.position = CGPoint(x: size.width/2, y: size.height*0.8)
        addChild(title)
        
        // MARK: - Trail Options
        let trailNames = ["Green Trail", "Red Trail", "Blue Trail"]
        for (i, name) in trailNames.enumerated() {
            let button = SKLabelNode(text: name)
            button.fontName = "Chalkduster"
            button.fontSize = 80
            button.fontColor = .yellow
            button.position = CGPoint(x: size.width/2, y: size.height*0.6 - CGFloat(i)*120)
            button.name = "trail_\(i)"
            addChild(button)
        }
        
        // MARK: - Back Button
        let backButton = SKLabelNode(text: "BACK")
        backButton.fontName = "Chalkduster"
        backButton.fontSize = 90
        backButton.fontColor = .white
        backButton.position = CGPoint(x: size.width/2, y: 100)
        backButton.name = "backButton"
        addChild(backButton)
    }

    // MARK: - Touch Handling
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodesAtPoint = nodes(at: location)
        
        for node in nodesAtPoint {
            guard let name = node.name else { continue }
            if name.starts(with: "trail_") {
                // TODO: implement buy/select trail logic
                print("Selected \(name)")
            } else if name == "backButton" {
                let scene = MainMenuScene(size: size)
                scene.scaleMode = .aspectFill
                view?.presentScene(scene, transition: .flipVertical(withDuration: 0.5))
            }
        }
    }
}
