//
//  JobCell.swift
//  GitJobs
//
//  Created by Rustam on 02.04.2021.
//

import UIKit

class JobCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var lblApply: UILabel!
    
    var presenter: JobCellPresenterP? {
        didSet {
            lblTitle.text = presenter?.job.title
            lblCompanyName.attributedText = presenter?.job.company.htmlAttributedString
            lblApply.attributedText = presenter?.job.howApply.htmlAttributedString
        }
    }
}
