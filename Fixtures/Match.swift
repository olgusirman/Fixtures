import Foundation
import Alamofire

struct Match {

    let homeTeamName: String
    let awayTeamName: String

    init?(json: [String : Any]) {
        guard let homeTeam = json["homeTeam"] as? [String: Any],
            let awayTeam = json["awayTeam"] as? [String: Any],
            let homeTeamName = awayTeam["name"] as? String,
            let awayTeamName = homeTeam["name"] as? String
            else { return nil }

        self.homeTeamName = homeTeamName
        self.awayTeamName = awayTeamName
    }

    static func fetchMatches(completionHandler: @escaping (([Match]?) -> Void)) {
        let headers: HTTPHeaders = [
            "X-Auth-Token": "3ee966f08dbd47fb8bf5c3d378d541a5"
        ]

        Alamofire.request("http://api.football-data.org/v2/competitions/ELC/matches", headers: headers).responseJSON { response in
            if let json = response.result.value as? [String: Any] {
                let matches = json["matches"] as? [[String: Any]]

                var collection: [Match] = []

                matches?.forEach {
                    if let match = Match(json: $0) {
                        collection.append(match)
                    }
                }

                completionHandler(collection)
            }
        }
    }
}
