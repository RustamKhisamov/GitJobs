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
}
