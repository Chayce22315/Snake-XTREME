import GameKit
class GameCenterManager{
 static let shared=GameCenterManager()
 func auth(){
  GKLocalPlayer.local.authenticateHandler={_,_ in}
 }
 func score(_ v:Int){
  let s=GKScore(leaderboardIdentifier:"snakeXtreme_highscore")
  s.value=Int64(v)
  GKScore.report([s],withCompletionHandler:nil)
 }
}