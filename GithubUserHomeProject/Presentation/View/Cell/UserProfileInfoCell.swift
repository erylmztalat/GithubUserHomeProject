//
//  UserProfileInfoCell.swift
//  GithubUserHomeProject
//
//  Created by talate on 5.11.2023.
//

import UIKit

class UserProfileInfoCell: BaseTableViewCell<UserProfileInfoSection>, ConfiguringCellProtocol {
    static var reuseIdentifier: String = "UserProfileInfoCell"
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .darkGray
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .darkGray
        label.numberOfLines = 2
        return label
    }()
    
    override func setupLayout() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        selectionStyle = .none
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor)
        ])
    }
    
    override func configure(with item: UserProfileInfoSection?) {
        guard let userProfileInfo = item else { return }
        
        iconImageView.image = userProfileInfo.icon.withRenderingMode(.alwaysTemplate)
        titleLabel.text = userProfileInfo.text
    }
}

