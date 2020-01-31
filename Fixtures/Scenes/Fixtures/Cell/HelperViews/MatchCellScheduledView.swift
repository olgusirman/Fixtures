//
//  MatchCellScheduledView.swift
//  Fixtures
//
//  Created by Olgu on 31.01.2020.
//  Copyright © 2020 InCrowd Sports. All rights reserved.
//

import RxSwift
import RxCocoa

final class MatchCellScheduledView: UIView {
    @IBOutlet fileprivate weak var matchHourLabel: UILabel!
}

extension Reactive where Base: MatchCellScheduledView {
    
    var match: Binder<Match> {
        return Binder(base) { view, match in
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            view.matchHourLabel.text = formatter.string(from: match.utcDate)
        }
    }
}
