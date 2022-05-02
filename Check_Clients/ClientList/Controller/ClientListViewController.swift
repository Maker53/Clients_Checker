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

    // MARK: - Lifecycle 
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: Не будет ли тут проблем с чтением из базы, когда база будет огромной
        // мб стоит использовать многопоточку
        clients = realm.objects(Client.self)
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollToCurrentDate()
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
    func getSortedClients(from clientList: Results<Client>!) -> [(date: Date, clients: [Client])] {
        ClientListDisplayDataParser.shared.getGroupedClients(from: clientList)
    }
    
    func getClient(from clientList: Results<Client>!, indexPath: IndexPath) -> Client {
        let sortedClients = getSortedClients(from: clientList)
        let client = sortedClients[indexPath.section].clients[indexPath.row]
        
        return client
    }
    
    func scrollToCurrentDate() {
        var sectionForScroll: Int?
        let currentDate = dateFormatter.string(from: Date())
        let sortedClients = getSortedClients(from: clients)
        
        // Если массив пустой, то досрочно выйдем из метода не проскроллив, чтобы
        // не вызвать ошибку рантайма.
        if sortedClients.count == 0 {
            return
        }
        
        // Перебор готового сортированного по датам массива кортежей с клиентами для получения
        // индекса в массиве и привязке этого индекса к секции в таблице.
        // Перебираем не в методах TableViewDataSource, так как там проходит слишком много
        // итераций, что задействует больше ресурсов, а здесь данный метод выполнится один раз
        // при появлении вьюхи на экране в методе viewDidAppear.
        for section in 0..<sortedClients.count {
            let stringDate = dateFormatter.string(from: sortedClients[section].date)
            let date = sortedClients[section].date
            
            // Проверяем по сегодняшней дате.
            // Если первое условие не сработало и sectionForScroll все еще nil,
            // значит совпадений по текущей дате нет и следующая за ней дата
            // нам и нужна для скроллинга к ней
            if currentDate == stringDate {
                sectionForScroll = section
            } else if sectionForScroll == nil, date > Date() {
                sectionForScroll = section
            }
        }
        
        // Если нет совпадений ни по текущей дате, ни по дате следующей за ней,
        // значит есть даты до текущей. Берем последнюю в списке клиентов - она будет
        // ближайшей к текущей дате в отрицательную сторону. 
        if sectionForScroll == nil {
            sectionForScroll = sortedClients.count - 1
        }
        
        print("hello!!!")
        let indexPath = IndexPath(row: 0, section: sectionForScroll ?? 0)
        
        tableView.scrollToRow(at: indexPath, at: .top, animated: false)
    }
}
