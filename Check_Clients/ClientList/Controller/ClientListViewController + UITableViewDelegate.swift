//
//  ClientListViewController + UITableViewDelegate.swift
//  Check_Clients
//
//  Created by Станислав on 13.04.2022.
//

import UIKit

extension ClientListViewController: UITableViewDelegate {
    // TODO: Вызывать в методах UITableViewDelegate подготовленные данные из parser
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let allData = getData().allData else { return }
            guard let visitTimes = getData().visitTimes else { return }
            
            guard let clients = allData[visitTimes[indexPath.section]] else { return }
            let client = clients[indexPath.row]
            
            StorageManager.delete(client)
            let section = IndexSet(integer: indexPath.section)
            
            if clients.count == 1 {
                tableView.deleteSections(section, with: .automatic)
            } else {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
}
