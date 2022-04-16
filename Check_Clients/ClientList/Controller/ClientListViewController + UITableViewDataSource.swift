//
//  ClientListViewController + UITableViewDataSource.swift
//  Check_Clients
//
//  Created by Станислав on 13.04.2022.
//

import UIKit

extension ClientListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        clients.isEmpty ? 0 : clients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ClientCell.identifier, for: indexPath)
        guard let cell = cell as? ClientCell else { return cell }
        
        let client = clients[indexPath.row]
        
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
