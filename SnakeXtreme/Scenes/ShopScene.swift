import SpriteKit
class ShopScene:SKScene{
 let trails=[("fire",50),("neon",100),("toxic",150),("rainbow",300),("lightning",500)]
 override func didMove(to view:SKView){backgroundColor=.darkGray;drawUI()}
 func drawUI(){
  var y=frame.height-100
  for (id,cost) in trails{
   let btn=SKLabelNode(text:"\(id.uppercased()) - \(cost) coins");btn.position=CGPoint(x:frame.midX,y:y);btn.name=id;btn.fontName="Menlo-Bold";btn.fontSize=28;addChild(btn);y-=60
  }
  let coinsLabel=SKLabelNode(text:"Coins: \(GameManager.shared.coins)");coinsLabel.position=CGPoint(x: frame.midX,y:50);coinsLabel.fontName="Menlo-Bold";coinsLabel.fontSize=28;addChild(coinsLabel)
 }
 override func touchesEnded(_ touches:Set<UITouch>,with event:UIEvent?){
  guard let t=touches.first else{return};let n=atPoint(t.location(in:self))
  guard let id=n.name else{return}
  if let trail=trails.first(where:{$0.0==id}){
   let success=GameManager.shared.buyTrail(id:id,cost:trail.1)
   GameManager.shared.equipTrail(id:id)
   removeAllChildren();drawUI()
  }
 }
}