//
//  UserProfileViewController.swift
//  GithubUserHomeProject
//
//  Created by talate on 5.11.2023.
//

import UIKit

class UserProfileViewController: UIViewController, AlertPresentable {
    
    private let viewModel: UserProfileViewModel
    private let userID: String
    private let userType: UserType
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UserProfileImageCell.self, forCellReuseIdentifier: UserProfileImageCell.reuseIdentifier)
        tableView.register(UserProfileInfoCell.self, forCellReuseIdentifier: UserProfileInfoCell.reuseIdentifier)
        tableView.register(UserProfileFooterCell.self, forCellReuseIdentifier: UserProfileFooterCell.reuseIdentifier)
        return tableView
    }()
    
    init(viewModel: UserProfileViewModel, userID: String, userType: UserType) {
        self.viewModel = viewModel
        self.userID = userID
        self.userType = userType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.fetchUserProfile(userID: self.userID)
    }
    
    private func setupUI() {
        self.title = self.userType.title
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.$userProfile
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &viewModel.cancellables)
        
        viewModel.$error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let error = error else { return }
                self?.showAlert(title: "Network Error", message: error.description)
            }
            .store(in: &viewModel.cancellables)
    }
}

// MARK: - UITableViewDataSource
extension UserProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let profileSection = UserProfileSection(rawValue: section)
        switch profileSection {
        case .image:
            return 1
        case .info:
            return viewModel.userProfile?.profileInfoSections.count ?? 0
        case .footer:
            return 1
        case .none:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return UserProfileSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let profileSection = UserProfileSection(rawValue: indexPath.section)
        switch profileSection {
        case .image:
            let cell = tableView.dequeueReusableCell(withIdentifier: UserProfileImageCell.reuseIdentifier, for: indexPath) as! UserProfileImageCell
            cell.item = viewModel.userProfile?.profileImageSection
            return cell
        case .info:
            let cell = tableView.dequeueReusableCell(withIdentifier: UserProfileInfoCell.reuseIdentifier, for: indexPath) as! UserProfileInfoCell
            cell.item = viewModel.userProfile?.profileInfoSections[indexPath.row]
            return cell
        case .footer:
            let cell = tableView.dequeueReusableCell(withIdentifier: UserProfileFooterCell.reuseIdentifier, for: indexPath) as! UserProfileFooterCell
            cell.item = viewModel.userProfile?.profileFooterSection
            return cell
        case .none:
            return UITableViewCell()
        }
    }
}

extension UserProfileViewController: UITableViewDelegate {}

