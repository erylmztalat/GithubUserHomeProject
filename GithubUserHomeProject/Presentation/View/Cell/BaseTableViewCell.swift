//
//  BaseTableViewCell.swift
//  GithubUserHomeProject
//
//  Created by talate on 5.11.2023.
//

import UIKit

class BaseTableViewCell<T> : UITableViewCell {
    
    var item : T? {
        didSet {
            setupLayout()
            configure(with: self.item)
        }
    }
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {}
    func configure(with item: T?) {}
}

