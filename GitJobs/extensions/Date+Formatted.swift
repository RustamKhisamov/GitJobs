//
//  Date+Formatted.swift
//  GitJobs
//
//  Created by Rustam on 04.04.2021.
//

import Foundation

extension Date {
    
    static func formateToDate(string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        guard let date = dateFormatter.date(from: string) else {
            return Date()
        }
        return date
    }
    
    static func humanReadDate(string: String) -> String {
        let date = formateToDate(string: string)
        if Calendar.current.isDateInToday(date) {
            return "Today"
        } else if Calendar.current.isDateInYesterday(date) {
            return "Yesterday"
        }
        return string
    }
}
