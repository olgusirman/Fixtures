//
//  MatchCellScoreView.swift
//  Fixtures
//
//  Created by Olgu on 31.01.2020.
//  Copyright © 2020 InCrowd Sports. All rights reserved.
//

import RxSwift
import RxCocoa

final class MatchCellScoreView: UIView {
    @IBOutlet fileprivate weak var dateLabel: UILabel!
    @IBOutlet fileprivate weak var homeScoreLabel: UILabel!
    @IBOutlet fileprivate weak var awayScoreLabel: UILabel!
}

extension Reactive where Base: MatchCellScoreView {
    
    var match: Binder<Match> {
        return Binder(base) { view, match in
            view.dateLabel.text = "-"
            view.homeScoreLabel.text = "-"
            view.awayScoreLabel.text = "-"
            if let score = match.score.fullTime?.homeTeam {
                view.homeScoreLabel.text = "\(score)"
            }
            if let score = match.score.fullTime?.awayTeam {
                view.awayScoreLabel.text = "\(score)"
            }
        }
    }
}
