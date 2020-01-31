//
//  MatchCellHeaderView.swift
//  Fixtures
//
//  Created by Olgu on 31.01.2020.
//  Copyright © 2020 InCrowd Sports. All rights reserved.
//

import RxSwift
import RxCocoa

final class MatchCellHeaderView: UIView {
    @IBOutlet fileprivate weak var matchAreaLabel: UILabel!
    @IBOutlet fileprivate weak var matchDateLabel: UILabel!
}

extension Reactive where Base: MatchCellHeaderView {
    
    var match: Binder<Match> {
        return Binder(base) { view, match in
            let formatter = DateFormatter()
            formatter.dateFormat = "E, d MMM yyyy"
            view.matchAreaLabel.text = match.competition.name ?? ""
            view.matchDateLabel.text = formatter.string(from: match.utcDate)
        }
    }
}
