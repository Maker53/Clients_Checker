//
//  ClientListViewController + ReloadClientListDelegate.swift
//  Check_Clients
//
//  Created by Станислав on 14.04.2022.
//

protocol ReloadClientListDelegate: AnyObject {
    func reloadClientList()
}

extension ClientListViewController: ReloadClientListDelegate {
    func reloadClientList() {
        tableView.reloadData()
    }
}
