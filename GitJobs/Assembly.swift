//
//  Assembly.swift
//  GitJobs
//
//  Created by Rustam on 03.04.2021.
//

import UIKit

protocol AssemblyP {
    func resolve() -> JobsViewController
    func resolve() -> JobsPresenterP
    
    func resolve() -> ServiceP
    
    func resolve(with jobID: String) -> JobDetailsViewController
    func resolve(with jobID: String) -> JobDetailsPresenterP
}

final class Assembly: AssemblyP {
    
    func resolve() -> JobsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let jobsViewController: JobsViewController = storyboard.instantiateViewController(withIdentifier: "JobsViewController") as! JobsViewController
        jobsViewController.presenter = resolve()
        
        return jobsViewController
    }
    
    func resolve() -> JobsPresenterP {
        JobsPresenter(service: resolve(), assembly: self)
    }
    
    func resolve() -> ServiceP {
        Service(dataBase: DataBase<Job>())
    }
    
    func resolve(with jobID: String) -> JobDetailsViewController {
        let detailsViewController = JobDetailsViewController()
        detailsViewController.presenter = resolve(with: jobID)
        return detailsViewController
    }
    
    func resolve(with jobID: String) -> JobDetailsPresenterP {
        JobDetailsPresenter(jobID: jobID, service: resolve())
    }
}
