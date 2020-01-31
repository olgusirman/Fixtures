import UIKit
import Alamofire

class FixturesViewController: UITableViewController {

    private var matches: [Match]?

    override func viewDidLoad() {
        super.viewDidLoad()

        Match.fetchMatches {
            self.matches = $0
            self.tableView.reloadData()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "fixture", for: indexPath) as? FixtureTableViewCell,
            let match = matches?[indexPath.row]
            else { fatalError() }

        cell.homeTeamNameLabel.text = match.homeTeamName
        cell.awayTeamNameLabel.text = match.awayTeamName
        
        return cell
    }
}

class FixtureTableViewCell: UITableViewCell {

    @IBOutlet weak var homeTeamNameLabel: UILabel!
    @IBOutlet weak var awayTeamNameLabel: UILabel!
}
