//
//  ClientListViewController + UITableViewDataSource.swift
//  Check_Clients
//
//  Created by Станислав on 13.04.2022.
//

import UIKit

extension ClientListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if isFiltering {
            return getSortedClients(from: filteredClients).count
        } else {
            return getSortedClients(from: clients).count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionDate: Date
        let sectionHeader: String
        
        if isFiltering {
            sectionDate = getSortedClients(from: filteredClients)[section].date
        } else {
            sectionDate = getSortedClients(from: clients)[section].date
        }
        
        sectionHeader = dateFormatter.string(from: sectionDate)

        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return getSortedClients(from: filteredClients)[section].clients.count
        } else {
            return getSortedClients(from: clients)[section].clients.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ClientCell.identifier, for: indexPath)
        guard let cell = cell as? ClientCell else { return cell }
        
        var client: Client
        
        if isFiltering {
            client = getClient(from: filteredClients, indexPath: indexPath)
        } else {
            client = getClient(from: clients, indexPath: indexPath)
        }
        
        cell.doneTapAction = { tapLocation in
            DispatchQueue.main.async {
                try! realm.write {
                    client.isDone.toggle()
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                }
            }
        }
        cell.configure(with: client)
        
        return cell
    }
}
