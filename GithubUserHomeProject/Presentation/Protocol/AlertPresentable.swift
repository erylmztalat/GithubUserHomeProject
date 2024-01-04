//
//  AlertPresentable.swift
//  GithubUserHomeProject
//
//  Created by talate on 5.11.2023.
//

import UIKit

protocol AlertPresentable {
    func showAlert(title: String, message: String)
}

extension AlertPresentable where Self: UIViewController {
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

