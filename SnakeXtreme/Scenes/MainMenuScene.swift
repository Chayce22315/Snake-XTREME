import SpriteKit
class MainMenuScene:SKScene{
 override func didMove(to view:SKView){
  backgroundColor=.black
  let playBtn=SKLabelNode(text:"PLAY");playBtn.position=CGPoint(x:frame.midX,y:frame.midY+50);playBtn.name="play";playBtn.fontSize=40;addChild(playBtn)
  let shopBtn=SKLabelNode(text:"SHOP");shopBtn.position=CGPoint(x:frame.midX,y:frame.midY-50);shopBtn.name="shop";shopBtn.fontSize=40;addChild(shopBtn)
 }
 override func touchesEnded(_ touches:Set<UITouch>,with event:UIEvent?){
  guard let t=touches.first else{return}
  let n=atPoint(t.location(in:self))
  if n.name=="play"{let scene=GameScene(size:self.size);scene.scaleMode=.resizeFill;view?.presentScene(scene)}
  else if n.name=="shop"{let scene=ShopScene(size:self.size);scene.scaleMode=.resizeFill;view?.presentScene(scene)}
 }
}