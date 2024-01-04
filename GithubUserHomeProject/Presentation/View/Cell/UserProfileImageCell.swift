//
//  UserProfileImageCell.swift
//  GithubUserHomeProject
//
//  Created by talate on 5.11.2023.
//

import UIKit

class UserProfileImageCell: BaseTableViewCell<UserProfileImageSection>, ConfiguringCellProtocol {
    static var reuseIdentifier: String = "UserProfileImageCell"
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 60
        imageView.layer.borderWidth = 0.25
        imageView.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let seperatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    override func setupLayout() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(seperatorView)
        selectionStyle = .none
        
        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalToConstant: 120),
            avatarImageView.heightAnchor.constraint(equalToConstant: 120),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            avatarImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            usernameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            seperatorView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            seperatorView.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 30),
            seperatorView.heightAnchor.constraint(equalToConstant: 0.5),
            seperatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    override func configure(with item: UserProfileImageSection?) {
        guard let userProfileImage = item else { return }
        
        if let urlString = userProfileImage.imageURLString, let url = URL(string: urlString) {
            avatarImageView.setImage(from: url)
        }
        nameLabel.text = userProfileImage.name
        usernameLabel.text = userProfileImage.username
    }
}

