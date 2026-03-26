import SpriteKit
class PowerUpSystem{
 var turbo=false

 func activateTurbo(scene:GameScene){
  turbo=true
  scene.speed=2.0
  DispatchQueue.main.asyncAfter(deadline:.now()+2){
   self.turbo=false
   scene.speed=1.0
  }
 }
}