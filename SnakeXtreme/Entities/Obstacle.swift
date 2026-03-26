import SpriteKit
class Obstacle{
 var nodes:[SKShapeNode]=[]
 func spawn(in s:SKScene){
  for _ in 0..<5{
   let o=SKShapeNode(rectOf:CGSize(width:30,height:30))
   o.fillColor=.gray
   o.position=random(s)
   s.addChild(o)
   nodes.append(o)
  }
 }
 func random(_ s:SKScene)->CGPoint{
  CGPoint(x:CGFloat.random(in:50...s.frame.width-50),
          y:CGFloat.random(in:50...s.frame.height-50))
 }
}