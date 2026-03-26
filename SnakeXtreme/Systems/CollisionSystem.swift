import SpriteKit
class CollisionSystem{
 func food(snake:Snake,food:Food)->Bool{
  guard let h=snake.body.first else{return false}
  return h.frame.intersects(food.node.frame)
 }
 func wall(_ h:SKShapeNode,_ s:SKScene)->Bool{
  h.position.x<0||h.position.x>s.frame.width||
  h.position.y<0||h.position.y>s.frame.height
 }
 func obstacle(_ h:SKShapeNode,_ o:Obstacle)->Bool{
  for n in o.nodes{ if h.frame.intersects(n.frame){ return true } }
  return false
 }
}