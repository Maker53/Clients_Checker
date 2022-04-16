//
//  ClientListViewController.swift
//  Check_Clients
//
//  Created by Станислав on 13.04.2022.
//

import RealmSwift

class ClientListViewController: UIViewController {
    
    // MARK: - Public Properties
    lazy var tableView = UITableView(frame: .zero, style: .plain)
    var clients: Results<Client>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        clients = realm.objects(Client.self)
    }
    
    @objc func addClientButtonTapped() {
        let newClientVC = NewClientViewController()
        let navigationVC = UINavigationController(rootViewController: newClientVC)
        newClientVC.delegate = self
        present(navigationVC, animated: true)
    }
}
