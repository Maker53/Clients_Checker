//
//  ClientListViewController + UITableViewDataSource.swift
//  Check_Clients
//
//  Created by Станислав on 13.04.2022.
//

import UIKit

extension ClientListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        clients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ClientCell.identifier, for: indexPath)
        guard let cell = cell as? ClientCell else { return cell }
        
        cell.clientName.text = clients[indexPath.row].clientName
        cell.location.text = clients[indexPath.row].location
        cell.visitTime.text = clients[indexPath.row].visitTime.description
        
        return cell
    }
}
