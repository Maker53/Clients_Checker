//
//  ClientListViewController.swift
//  Check_Clients
//
//  Created by Станислав on 13.04.2022.
//

import UIKit

class ClientListViewController: UIViewController {
    
    // MARK: - Public Properties
    lazy var tableView = UITableView(frame: .zero, style: .plain)
    var clients = Client.mock

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    @objc func addClientButtonTapped() {
        let newClientVC = NewClientViewController()
        let navigationVC = UINavigationController(rootViewController: newClientVC)
        newClientVC.delegate = self
        present(navigationVC, animated: true)
    }
}
