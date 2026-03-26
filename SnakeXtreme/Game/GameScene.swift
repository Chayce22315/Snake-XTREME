import SpriteKit

class GameScene:SKScene{

 let snake=Snake()
 let food=Food()
 let obs=Obstacle()
 let col=CollisionSystem()
 let power=PowerUpSystem()
 let trail=TrailSystem()

 var timer:Timer?

 override func didMove(to view:SKView){
  backgroundColor=.black
  snake.spawn(in:self)
  food.spawn(in:self)
  obs.spawn(in:self)
  trail.attach(to:snake.body.first!)
  start()
 }

 func start(){
  timer=Timer.scheduledTimer(withTimeInterval:0.2,repeats:true){_ in self.tick()}
 }

 func tick(){
  snake.move(in:self)

  if col.food(snake:snake,food:food){
   GameManager.shared.score+=1
   GameManager.shared.addCoins(5)
   food.node.removeFromParent()
   food.spawn(in:self)
   power.activateTurbo(scene:self)
  } else {
   snake.trim()
  }

  if let h=snake.body.first{
   if col.wall(h,self)||col.obstacle(h,obs){ gameOver() }
  }
 }

 func gameOver(){
  timer?.invalidate()
  GameCenterManager.shared.score(GameManager.shared.score)
  removeAllChildren()
  snake.body.removeAll()
  obs.nodes.removeAll()
  GameManager.shared.reset()
  didMove(to:view!)
 }

 override func touchesEnded(_ t:Set<UITouch>,with e:UIEvent?){
  let l=t.first!.location(in:self)
  let h=snake.body.first!
  if abs(l.x-h.position.x)>abs(l.y-h.position.y){
   snake.dir = l.x>h.position.x ? CGVector(dx:40,dy:0):CGVector(dx:-40,dy:0)
  } else {
   snake.dir = l.y>h.position.y ? CGVector(dx:0,dy:40):CGVector(dx:0,dy:-40)
  }
 }
}
