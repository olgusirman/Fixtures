//
//  FixturesViewController.swift
//  Fixtures
//
//  Created by Olgu on 31.01.2020.
//  Copyright © 2020 InCrowd Sports. All rights reserved.
//

import UIKit
import RxCocoa
import RxDataSources
import Action
import RxSwift

final class FixturesViewController: UIViewController, StoryboardIdentifiable, BindableType {

    static var storyboardName: String {
        return "Main"
    }
    
    // MARK: - Outlets
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Properties
    var viewModel: FixturesViewModel!
    var bag = DisposeBag()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Fixtures"
        configureTableView()
        configureActivityIndicatorView()
    }

    func bindViewModel() {
        let outputs = viewModel.outputs
        let inputs = viewModel.inputs
        
        let dataSource = FixturesViewController.dataSource()
        
        outputs.matchCellViewModels
            .map { [FixturesSectionModel(header: "", items: $0)] }
            .drive( tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
        
        inputs.fetchMatches
            .executing
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: bag)
    }

}

// MARK: - Helper
extension FixturesViewController {

    fileprivate func configureTableView() {
        tableView.isEditing = false
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 197
        tableView.separatorStyle = .none

        tableView.register(cellType: MatchCell.self)
    }
    
    /// I can not set activittIndicatorView constraints inside the storyboard, I don't know why, I thinks It is some bug that I faced first time :]
    fileprivate func configureActivityIndicatorView() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
}
