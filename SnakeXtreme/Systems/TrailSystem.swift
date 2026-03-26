import SpriteKit
class TrailSystem{
 func attach(to node:SKNode){
  let emitter = SKEmitterNode()
  switch GameManager.shared.equippedTrail{
  case "fire":emitter.particleColor=.orange;emitter.particleSpeed=120
  case "neon":emitter.particleColor=.cyan;emitter.particleBlendMode=.add
  case "toxic":emitter.particleColor=.green
  case "rainbow":emitter.particleColorSequence=SKKeyframeSequence(keyframeValues:[UIColor.red,UIColor.orange,UIColor.yellow,UIColor.green,UIColor.blue,UIColor.purple],times:[0,0.2,0.4,0.6,0.8,1]);emitter.particleSpeed=80
  case "lightning":emitter.particleColor=.white;emitter.particleSpeed=200
  default:emitter.particleColor=.white
  }
  emitter.particleBirthRate=80;emitter.particleLifetime=0.4;emitter.particleScale=0.2
  emitter.targetNode=node.parent;node.addChild(emitter)
 }
}