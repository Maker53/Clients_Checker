//
//  SetupClientListViewController.swift
//  Check_Clients
//
//  Created by Станислав on 13.04.2022.
//

import UIKit

extension ClientListViewController {
    func setupUI() {
        title = "Client list"
        
        // Setup search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addClientButtonTapped)
        )
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInset = UIEdgeInsets(top: -22, left: 0, bottom: 0, right: 0)
        
        // TODO: Когда буду наводить красоту, не забыть подобрать размер ячейки и выставить
        // TODO: estimatedRowHeight равный высоте ячейки
        tableView.rowHeight = 50
        tableView.estimatedRowHeight = 50
        
        tableView.register(ClientCell.self, forCellReuseIdentifier: ClientCell.identifier)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
