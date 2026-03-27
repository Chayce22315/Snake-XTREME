import GameKit

class GameCenterManager {
    static let shared = GameCenterManager()

    func authenticate() {
        let player = GKLocalPlayer.local
        player.authenticateHandler = { vc, error in
            if let vc = vc {
                UIApplication.shared.windows.first?.rootViewController?.present(vc, animated: true)
            }
        }
    }

    func submitScore(_ score: Int) {
        let scoreReporter = GKScore(leaderboardIdentifier: "snake_highscore")
        scoreReporter.value = Int64(score)

        GKScore.report([scoreReporter]) { error in
            if let error = error {
                print("GC Error:", error)
            }
        }
    }
}
