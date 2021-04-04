//
//  JobCellPresenter.swift
//  GitJobs
//
//  Created by Rustam on 03.04.2021.
//

import Foundation

protocol JobCellPresenterP {
    var job: Job { get }
}

final class JobCellPresenter: JobCellPresenterP {
    
    let job: Job
    
    init(job: Job) {
        self.job = job
    }
}
