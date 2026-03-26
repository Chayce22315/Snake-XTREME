import UIKit
import SpriteKit
class GameViewController:UIViewController{
 override func viewDidLoad(){
  super.viewDidLoad()
  if let v=self.view as? SKView{
   let scene=MainMenuScene(size:v.bounds.size)
   scene.scaleMode = .resizeFill
   v.presentScene(scene)
  }
 }
 override var prefersStatusBarHidden:Bool{true}
}