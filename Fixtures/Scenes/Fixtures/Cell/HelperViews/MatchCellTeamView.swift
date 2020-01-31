//
//  MatchCellTeamView.swift
//  Fixtures
//
//  Created by Olgu on 31.01.2020.
//  Copyright © 2020 InCrowd Sports. All rights reserved.
//

import RxSwift
import RxCocoa
import Nuke

final class MatchCellTeamView: UIView {
    @IBOutlet fileprivate weak var teamLogoImageView: UIImageView!
    @IBOutlet fileprivate weak var teamNameLabel: UILabel!
}

extension Reactive where Base: MatchCellTeamView {
    
    var team: Binder<Team> {
        return Binder(base) { view, team in
            let placeholder = UIImage(named: "crest_placeholder")
            view.teamNameLabel.text = team.name
            view.teamLogoImageView.image = placeholder
            
            if let urlString = team.crestUrl,
                let url = URL(string: urlString) {
                let options = ImageLoadingOptions(
                    placeholder: placeholder,
                    transition: .fadeIn(duration: 0.33)
                )
                Nuke.loadImage(with: url, options: options, into: view.teamLogoImageView)
            }
        }
    }
}
