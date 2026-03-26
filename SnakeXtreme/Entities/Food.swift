import SpriteKit
class Food{
 var node:SKShapeNode!
 func spawn(in s:SKScene){
  node=SKShapeNode(circleOfRadius:10)
  node.fillColor=.red
  node.position=random(s)
  s.addChild(node)
 }
 func random(_ s:SKScene)->CGPoint{
  CGPoint(x:CGFloat.random(in:50...s.frame.width-50),
          y:CGFloat.random(in:50...s.frame.height-50))
 }
}