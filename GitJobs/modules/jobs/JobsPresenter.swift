//
//  JobsPresenter.swift
//  GitJobs
//
//  Created by Rustam on 02.04.2021.
//

import UIKit
import RxSwift
import RxCocoa

protocol JobsPresenterP {
    
    var state: Driver<JobsState> { get }
    var isLoading: Bool { get set }
    
    func loadItems(for page: Int)
    func showDetails(by id: String, viewController: UIViewController)
    
    func showAlert(with message: String, viewController: UIViewController)
}

final class JobsPresenter: RxBase, JobsPresenterP {
    
    var state: Driver<JobsState> {
        _state.asDriver()
    }
    
    var _state = BehaviorRelay(value: JobsState(items: nil, page: 0, endReach: false, error: nil))
    
    var isLoading = false
    
    private var service: ServiceP
    private var assembly: AssemblyP
    
    init(service: ServiceP, assembly: AssemblyP) {
        self.service = service
        self.assembly = assembly
    }
    
    func loadItems(for page: Int) {
        isLoading = true
        service.getList(page: page)
            .flatMap {
                guard let items = $0.items else {
                    return .just(JobsState(items: nil, page: 0, endReach: true, error: $0.error))
                }
                let sections = self.sectionsSortedByDate(jobs: items)
                return .just(JobsState(items: sections, page: page, endReach: items.isEmpty, error: nil))
            }.asObservable()
            .bind(to: _state)
            .disposed(by: disposeBag)
    }
    
    func showDetails(by id: String, viewController: UIViewController) {
        let details: JobDetailsViewController = assembly.resolve(with: id)
        viewController.present(details, animated: true)
    }
    
    func showAlert(with message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: "Error",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .cancel,
                                      handler: nil))
        viewController.present(alert, animated: true)
    }
    
    func sectionsSortedByDate(jobs: [Job]) -> [SectionModel] {
        Dictionary(grouping: jobs, by: { $0.createDate })
            .compactMap {
                SectionModel(header: Date.humanReadDate(string: $0.key),
                             date: Date.formateToDate(string: $0.key),
                             items: $0.value)
            }
            .sorted { $0.date > $1.date }
    }
}
