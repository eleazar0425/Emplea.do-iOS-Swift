//
//  JobsViewController.swift
//  Emplea.do
//
//  Created by Eleazar Estrella GB on 5/21/19.
//  Copyright © 2019 Eleazar Estrella. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NVActivityIndicatorView

class JobsViewController: UIViewController {
    
    var viewModel: JobsViewModelType!
    
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        tableView.rowHeight = 184
        tableView.register(UINib(nibName: "JobsTableViewCell", bundle: nil), forCellReuseIdentifier: "JobsTableViewCell")
        
        let outputs = viewModel.outputs
        let inputs = viewModel.inputs
        
        outputs.jobs.bind(to: tableView.rx.items(cellIdentifier: "JobsTableViewCell", cellType: JobsTableViewCell.self )) { row, job, cell in
            cell.bind(job: job)
        }.disposed(by: disposeBag)
        
        tableView.rx
            .reachedBottom()
            .skipUntil(outputs.isLoading)
            .bind(to: inputs.loadMore)
            .disposed(by: disposeBag)
        
        outputs.isLoading
            .observeOn(MainScheduler.instance)
            .subscribe( onNext: { [weak self] isLoading in
                if isLoading {
                    self?.activityIndicatorView.startAnimating()
                }else {
                    self?.activityIndicatorView.stopAnimating()
                }
            }).disposed(by: disposeBag)
        
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "filterIcon"), style: .plain, target: self, action: #selector(filterAction))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func filterAction(){
        let actions = [ UIAlertController.AlertAction(title: "None", style: .default),
                        UIAlertController.AlertAction(title: "Software Development", style: .default),
                        UIAlertController.AlertAction(title: "Web Development", style: .default),
                        UIAlertController.AlertAction(title: "Mobile Development", style: .default),
                        UIAlertController.AlertAction(title: "Networking", style: .default),
                        UIAlertController.AlertAction(title: "System Administrator", style: .default) ]
        
        UIAlertController.present(in: self, title: nil, message: nil, style: .actionSheet, actions: actions)
            .flatMap { index -> Observable<FilterBy> in
                let action = actions[index]
                let filter = FilterBy(rawValue: action.title!.replacingOccurrences(of: " ", with: ""))!
                return Observable.just(filter)
            }.observeOn(MainScheduler.instance)
            .subscribe( onNext: { [unowned self] filterBy in
                self.viewModel.inputs.filterByAction.execute(filterBy)
            }).disposed(by: disposeBag)
    }
}
