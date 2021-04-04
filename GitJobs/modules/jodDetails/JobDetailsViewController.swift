//
//  JodDetails.swift
//  GitJobs
//
//  Created by Rustam on 03.04.2021.
//

import UIKit
import RxSwift

struct AnchorConstants {
    static let top: CGFloat = 20
    static let leading: CGFloat = 20
    static let trailing: CGFloat = 20
    static let height: CGFloat = 40
    static let textViewHeight: CGFloat = 300
}

final class JobDetailsViewController: RxViewController {
    
    var presenter: JobDetailsPresenterP!
    
    let lblTitle = UILabel()
    let lblCompanyName = UILabel()
    let lblApply = UILabel()
    let tvDescription = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter
            .getJob()
            .subscribe(onNext: { [unowned self] job in
                self.lblTitle.text = job.title
                self.lblCompanyName.attributedText = job.company.htmlAttributedString
                self.lblApply.attributedText = job.howApply.htmlAttributedString
                self.tvDescription.attributedText = job.jobDescription.htmlAttributedString
            }, onError: { error in
                guard (error as? GJError) != nil else { return }
                self.presenter.showAlert(with: GJError.emptyDetails.message, viewController: self)
            }).disposed(by: disposeBag)
    }
    
    private func setupUI() {
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        
        [lblTitle, lblCompanyName, lblApply].forEach { [unowned self] in
            $0.numberOfLines = 0
            $0.textColor = .black
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        }
        
        tvDescription.textColor = .black
        tvDescription.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tvDescription)
        
        setupConstrains()
    }
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            lblTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            lblTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: AnchorConstants.leading),
            lblTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -AnchorConstants.trailing),
            lblTitle.heightAnchor.constraint(equalToConstant: AnchorConstants.height),
            
            lblCompanyName.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: AnchorConstants.top),
            lblCompanyName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: AnchorConstants.leading),
            lblCompanyName.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -AnchorConstants.trailing),
            lblCompanyName.heightAnchor.constraint(greaterThanOrEqualToConstant: AnchorConstants.height),
            
            lblApply.topAnchor.constraint(equalTo: lblCompanyName.bottomAnchor, constant: AnchorConstants.top),
            lblApply.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: AnchorConstants.leading),
            lblApply.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -AnchorConstants.trailing),
            lblApply.heightAnchor.constraint(greaterThanOrEqualToConstant: AnchorConstants.height),
            
            tvDescription.topAnchor.constraint(equalTo: lblApply.bottomAnchor, constant: AnchorConstants.top),
            tvDescription.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: AnchorConstants.leading),
            tvDescription.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -AnchorConstants.trailing),
            tvDescription.heightAnchor.constraint(equalToConstant: AnchorConstants.textViewHeight),
        ])
    }
}
