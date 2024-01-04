//
//  UserProfileFooterCell.swift
//  GithubUserHomeProject
//
//  Created by talate on 5.11.2023.
//

import UIKit

class UserProfileFooterCell: BaseTableViewCell<UserProfileFooterSection>, ConfiguringCellProtocol {
    
    static var reuseIdentifier = "UserProfileFooterCell"

    private lazy var githubButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("View on GitHub", for: .normal)
        button.setImage(UIImage(named: "github"), for: .normal)
        button.tintColor = .darkGray
        button.layer.borderWidth = 0.7
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.cornerRadius = 8
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var joinedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private var githubURLString: String?
    
    override func setupLayout() {
        contentView.addSubview(githubButton)
        contentView.addSubview(joinedLabel)
        
        NSLayoutConstraint.activate([
            githubButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            githubButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            githubButton.widthAnchor.constraint(equalToConstant: 150),
            githubButton.heightAnchor.constraint(equalToConstant: 50),
            
            joinedLabel.topAnchor.constraint(equalTo: githubButton.bottomAnchor, constant: 10),
            joinedLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            joinedLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    override func configure(with item: UserProfileFooterSection?) {
        guard let userProfileFooter = item else { return }
        self.githubURLString = userProfileFooter.githubURLString
        self.githubButton.isHidden = (self.githubURLString != nil) ? false : true
        self.githubButton.addTarget(self, action: #selector(openGitHub), for: .touchUpInside)
        let dateFormatter = CustomDateFormatter()
        if let joinedDateString = userProfileFooter.joinedDate, let joinedDate = dateFormatter.joinedDate(from: joinedDateString) {
            joinedLabel.text = dateFormatter.joinedString(from: joinedDate)
        }
    }
    
    @objc func openGitHub() {
        guard let githubURLString = githubURLString, let url = URL(string: githubURLString) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Unable to open URL: \(url)")
        }
    }
}
