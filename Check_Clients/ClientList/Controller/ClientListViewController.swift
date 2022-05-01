//
//  ClientListViewController.swift
//  Check_Clients
//
//  Created by Станислав on 13.04.2022.
//

import RealmSwift
import UIKit

class ClientListViewController: UIViewController {
    
    // MARK: - Public Properties
    let searchController = UISearchController(searchResultsController: nil)
    var tableView = UITableView(frame: .zero, style: .plain)
    var sectionForScroll: Int?
    var clients: Results<Client>!
    var filteredClients: Results<Client>!
    var isFiltering: Bool {
        searchController.isActive && !searchBarIsEmpty
    }
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.setLocalizedDateFormatFromTemplate("dd-MMM-YY")
        
        return dateFormatter
    }()
    
    // MARK: - Private Properties
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }

    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: Не будет ли тут проблем с чтением из базы, когда база будет огромной
        // мб стоит использовать многопоточку
        clients = realm.objects(Client.self)
        
        setupUI()
    }
    
    // MARK: - @objc Action Method
    @objc func addClientButtonTapped() {
        let newClientViewController = NewClientViewController()
        let newClientNavigationController =  UINavigationController(
            rootViewController: newClientViewController)
        
        newClientViewController.delegate = self
        
        present(newClientNavigationController, animated: true)
    }
    
    // MARK: - Public Properties
    func getSortedClients(from clientList: Results<Client>!) -> [(date: String, clients: [Client])] {
        ClientListDisplayDataParser.shared.getGroupedClients(from: clientList)
    }
    
    func getClient(from clientList: Results<Client>!, indexPath: IndexPath) -> Client {
        let sortedClients = getSortedClients(from: clientList)
        let client = sortedClients[indexPath.section].clients[indexPath.row]
        
        return client
    }
    
    func scrollToCurrentDate() {
        let indexPath = IndexPath(row: 0, section: sectionForScroll ?? 0)
        
        tableView.scrollToRow(at: indexPath, at: .top, animated: false)
    }
}
