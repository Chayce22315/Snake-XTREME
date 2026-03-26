import SpriteKit
class Snake{
 var body:[SKShapeNode]=[]
 var dir=CGVector(dx:40,dy:0)

 func spawn(in s:SKScene){
  let h=SKShapeNode(rectOf:CGSize(width:20,height:20))
  h.fillColor=.green
  h.position=CGPoint(x:s.frame.midX,y:s.frame.midY)
  s.addChild(h)
  body=[h]
 }

 func move(in s:SKScene){
  guard let h=body.first else{return}
  let n=SKShapeNode(rectOf:CGSize(width:20,height:20))
  n.fillColor=.green
  n.position=CGPoint(x:h.position.x+dir.dx,y:h.position.y+dir.dy)
  s.addChild(n)
  body.insert(n,at:0)
 }

 func trim(){
  body.removeLast().removeFromParent()
 }
}