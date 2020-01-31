//
//  MatchCell.swift
//  Fixtures
//
//  Created by Olgu on 31.01.2020.
//  Copyright © 2020 InCrowd Sports. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Nuke

final class MatchCell: UITableViewCell, BindableType, NibIdentifiable & ClassIdentifiable {
    
    // MARK: - Outlets
    @IBOutlet fileprivate weak var headerView: MatchCellHeaderView!
    @IBOutlet fileprivate weak var homeTeamView: MatchCellTeamView!
    @IBOutlet fileprivate weak var awayTeamView: MatchCellTeamView!
    @IBOutlet fileprivate weak var scoreView: MatchCellScoreView!
    @IBOutlet fileprivate weak var scheduledView: MatchCellScheduledView!
    
    // MARK: - ViewModel
    var viewModel: MatchCellViewModelType!
    
    // MARK: - Properties
    var bag = DisposeBag()
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }
    
    func bindViewModel() {
        
        let output = viewModel.output
        let match = output.matchObs
        
        // Bind Home Team
        match.map({ $0.homeTeam })
            .drive(homeTeamView.rx.team)
            .disposed(by: bag)
        
        match.map({ $0.awayTeam })
            .drive(awayTeamView.rx.team)
            .disposed(by: bag)
        
        match.map({ $0 })
            .drive(scoreView.rx.match)
            .disposed(by: bag)
        
        match.map({ $0 })
            .drive(headerView.rx.match)
            .disposed(by: bag)
        
        match.map({ $0 })
            .drive(scheduledView.rx.match)
            .disposed(by: bag)
        
        bindFinishedStatus(match: match)
    }
    
    private func configureCell() {
        backgroundColor = UIColor.white
        selectionStyle = .none
    }
    
    private func bindFinishedStatus(match : Driver<Match>) {
        let finished = match.map({ $0.status == .finished })
        
        finished
            .drive(scheduledView.rx.isHidden)
            .disposed(by: bag)
        
        finished
            .map({ !$0 })
            .drive(scoreView.rx.isHidden)
            .disposed(by: bag)
        
        finished.map({
            if #available(iOS 13, *) {
                return $0 ? UIColor.systemOrange : UIColor.systemBackground
            } else {
                return $0 ? UIColor.orange : UIColor.white
            }
        })
            .drive(self.contentView.rx.backgroundColor)
            .disposed(by: bag)
    }
    
}
