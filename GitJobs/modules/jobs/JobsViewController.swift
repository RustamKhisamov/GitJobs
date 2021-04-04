//
//  ViewController.swift
//  GitJobs
//
//  Created by Rustam on 01.04.2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class JobsViewController: RxViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: JobsPresenterP!
    
    private let defaultOffset: CGFloat = 20
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subscribeState()
        processTableViewActions()
        
        presenter.loadItems(for: 1)
    }

    private func subscribeState() {
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel>(
            configureCell: { (_, tv, indexPath, item) in
                let cell = tv.dequeueReusableCell(withIdentifier: "JobCell") as! JobCell
                self.presenter.isLoading = false
                cell.presenter = JobCellPresenter(job: item)
                return cell
            },
            titleForHeaderInSection: { dataSource, sectionIndex in
                return dataSource[sectionIndex].header
            }
        )
        
        let state = presenter.state
        
        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        state
            .filter { $0.error == nil && !$0.endReach && $0.items != nil }
            .distinctUntilChanged { $0.items == $1.items }
            .map { $0.items! }
            .asDriver()
            .drive(tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        state
            .filter { $0.error != nil }
            .map { $0.error! }
            .asDriver()
            .drive { [unowned self] error in
                self.presenter.showAlert(with: error.message, viewController: self)
            }.disposed(by: disposeBag)
    }
    
    private func processTableViewActions() {
        
        tableView.rx
            .contentOffset
            .asDriver()
            .filter { [unowned self] _ in !self.presenter.isLoading }
            .withLatestFrom(presenter.state)
            .skip(1)
            .filter { [unowned self] state in
                self.tableView.isNearBottomEdge(edgeOffset: defaultOffset)  && !state.endReach
            }
            .drive { [unowned self] state in
                self.presenter.loadItems(for: state.page + 1)
            }.disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(Job.self)
            .subscribe(onNext: { [unowned self] item in
                self.presenter.showDetails(by: item.jobId, viewController: self)
            }).disposed(by: disposeBag)
    }
}
