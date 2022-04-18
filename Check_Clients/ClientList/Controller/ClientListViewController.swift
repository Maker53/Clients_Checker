//
//  ClientListViewController.swift
//  Check_Clients
//
//  Created by Станислав on 13.04.2022.
//

import RealmSwift
import Foundation

class ClientListViewController: UIViewController {
    
    // MARK: - Public Properties
    lazy var newClientViewController = NewClientViewController()
    lazy var newClientNavigationController: UINavigationController = {
        let navigationController = UINavigationController(
            rootViewController: newClientViewController)
        
        return navigationController
    }()
    lazy var tableView = UITableView(frame: .zero, style: .plain)
    var clients: Results<Client>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        clients = realm.objects(Client.self)
    }
    
    @objc func addClientButtonTapped() {
        newClientViewController.delegate = self
        present(newClientNavigationController, animated: true)
    }
    
    func getData() -> DisplayData {
        ClientListDisplayDataParser.shared.getData(from: clients)
    }
    
    func getClientBy(indexPath: IndexPath) -> Client? {
        guard let allData = getData().allData else { return nil }
        guard let visitTimes = getData().visitTimes else { return nil }
        
        guard let clients = allData[visitTimes[indexPath.section]] else { return nil }
        let client = clients[indexPath.row]
        
        return client
    }
}
