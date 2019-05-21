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
import RxDataSources

class JobsViewController: UIViewController {
    
    var viewModel: JobsViewModelType!
    
    private var tableViewDataSource: RxTableViewSectionedReloadDataSource<SectionModel<String, Job>>.ConfigureCell {
        return { _ , tableView, indexPath, cellModel in
            let cell = tableView.dequeueReusableCell(withIdentifier: "JobsTableViewCell", for: indexPath) as! JobsTableViewCell
            cell.bind(job: cellModel)
            
            return cell
        }
    }
    private var dataSource: RxTableViewSectionedReloadDataSource<SectionModel<String, Job>>!
    
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        tableView.rowHeight = 184
        tableView.register(UINib(nibName: "JobsTableViewCell", bundle: nil), forCellReuseIdentifier: "JobsTableViewCell")
        
        dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Job>>(
            configureCell: tableViewDataSource
        )
        
        viewModel
            .outputs
            .jobs
            .map { [SectionModel(model: "", items: $0)] }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

}
