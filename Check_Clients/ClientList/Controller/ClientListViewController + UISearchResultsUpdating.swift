//
//  ClientListViewController + UISearchResultsUpdating.swift
//  Check_Clients
//
//  Created by Станислав on 23.04.2022.
//

import UIKit

extension ClientListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredClients = clients.filter(
            "clientName CONTAINS[c] %@ OR location CONTAINS[c] %@", searchText, searchText)
        
        tableView.reloadData()
    }
}
