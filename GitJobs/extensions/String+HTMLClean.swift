//
//  String+HTMLClean.swift
//  GitJobs
//
//  Created by Rustam on 03.04.2021.
//

import Foundation

extension String {
    var htmlAttributedString: NSAttributedString? {
        return try? NSAttributedString(data: Data(utf8),
                                       options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
                                       documentAttributes: nil)
    }
    
    func formateToDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        guard let date = dateFormatter.date(from: self) else {
            return Date()
        }
        return date
    }
    
    func humanReadDate() -> String {
        let date = formateToDate()
        if Calendar.current.isDateInToday(date) {
            return "Today"
        } else if Calendar.current.isDateInYesterday(date){
            return "Yesterday"
        }
        return self
    }
}
