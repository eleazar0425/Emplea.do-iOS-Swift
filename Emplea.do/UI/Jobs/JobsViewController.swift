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
    }

}
