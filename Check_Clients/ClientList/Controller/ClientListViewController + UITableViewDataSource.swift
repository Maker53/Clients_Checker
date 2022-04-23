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
            return getData(from: filteredClients).visitTimes?.count ?? 0
        } else {
            return getData(from: clients).visitTimes?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isFiltering {
            return getData(from: filteredClients).visitTimes?[section]
        } else {
            return getData(from: clients).visitTimes?[section]
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            let allData = getData(from: filteredClients).allData
            let visitTimes = getData(from: filteredClients).visitTimes
            return allData?[visitTimes?[section] ?? ""]?.count ?? 0
        } else {
            let allData = getData(from: clients).allData
            let visitTimes = getData(from: clients).visitTimes
            return allData?[visitTimes?[section] ?? ""]?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ClientCell.identifier, for: indexPath)
        guard let cell = cell as? ClientCell else { return cell }
        
        var client: Client?
        
        if isFiltering {
            client = getClientBy(from: filteredClients, indexPath: indexPath)
        } else {
            client = getClientBy(from: clients, indexPath: indexPath)
        }
        
                
        cell.doneTapAction = { tapLocation in
            DispatchQueue.main.async {
                try! realm.write {
                    client?.isDone.toggle()
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                }
            }
        }
        cell.configure(with: client)
        
        return cell
    }
}
