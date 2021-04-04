//
//  JobDetailsPresenter.swift
//  GitJobs
//
//  Created by Rustam on 03.04.2021.
//

import UIKit
import RxSwift
import RxCocoa

protocol JobDetailsPresenterP {
    func getJob() -> Observable<Job>
    func showAlert(with message: String, viewController: UIViewController)
}

final class JobDetailsPresenter: RxBase, JobDetailsPresenterP {
    
    private let jobID: String
    private let service: ServiceP
    
    init(jobID: String, service: ServiceP) {
        self.jobID = jobID
        self.service = service
    }
    
    func getJob() -> Observable<Job> {
        service
            .cachedJob(by: jobID)
            .asObservable()
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
}
