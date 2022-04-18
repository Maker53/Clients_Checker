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
            guard let client = getClientBy(indexPath: indexPath) else { return }
            
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
