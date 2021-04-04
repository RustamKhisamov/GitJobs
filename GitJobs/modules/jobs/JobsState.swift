//
//  JobsState.swift
//  GitJobs
//
//  Created by Rustam on 04.04.2021.
//

import Foundation

struct JobsState {
    
    var items: [SectionModel]?
    var page = 0
    
    var endReach = false
    
    var error: GJError?
}
