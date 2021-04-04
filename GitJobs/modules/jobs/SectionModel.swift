//
//  Section.swift
//  GitJobs
//
//  Created by Rustam on 04.04.2021.
//

import Foundation
import RxDataSources

struct SectionModel: Equatable {
    var header: String
    var date: Date
    var items: [Job]
}

extension SectionModel: SectionModelType {
    
    typealias Item = Job
    
    init(original: SectionModel, items: [Item]) {
        self = original
        self.items = items
    }
}
