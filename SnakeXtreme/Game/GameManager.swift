class GameManager{
 static let shared = GameManager()
 var score = 0
 var coins = 0
 var ownedTrails: [String] = ["default"]
 var equippedTrail: String = "default"
 func addCoins(_ c:Int){coins+=c}
 func buyTrail(id:String,cost:Int)->Bool{
  if coins>=cost && !ownedTrails.contains(id){
   coins-=cost
   ownedTrails.append(id)
   return true
  }
  return false
 }
 func equipTrail(id:String){if ownedTrails.contains(id){equippedTrail=id}}
 func reset(){score=0}
}