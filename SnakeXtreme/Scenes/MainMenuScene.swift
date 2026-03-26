import SpriteKit

class MainMenuScene: SKScene {

    override func didMove(to view: SKView) {
        backgroundColor = .black

        let title = SKLabelNode(text: "SNAKEXTREME")
        title.fontName = "Chalkduster"
        title.fontSize = 120
        title.fontColor = .green
        title.position = CGPoint(x: size.width/2, y: size.height*0.7)
        addChild(title)

        let playButton = SKLabelNode(text: "PLAY")
        playButton.fontName = "Chalkduster"
        playButton.fontSize = 100
        playButton.fontColor = .white
        playButton.position = CGPoint(x: size.width/2, y: size.height*0.5)
        playButton.name = "playButton"
        addChild(playButton)

        let shopButton = SKLabelNode(text: "SHOP")
        shopButton.fontName = "Chalkduster"
        shopButton.fontSize = 100
        shopButton.fontColor = .yellow
        shopButton.position = CGPoint(x: size.width/2, y: size.height*0.35)
        shopButton.name = "shopButton"
        addChild(shopButton)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodesAtPoint = nodes(at: location)
        for node in nodesAtPoint {
            if node.name == "playButton" {
                let scene = GameScene(size: size)
                scene.scaleMode = .aspectFill
                view?.presentScene(scene, transition: .doorsOpenHorizontal(withDuration: 0.5))
            } else if node.name == "shopButton" {
                let scene = ShopScene(size: size)
                scene.scaleMode = .aspectFill
                view?.presentScene(scene, transition: .doorsOpenVertical(withDuration: 0.5))
            }
        }
    }
}
