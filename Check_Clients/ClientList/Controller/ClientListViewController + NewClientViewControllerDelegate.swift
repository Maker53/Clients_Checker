//
//  ClientListViewController + NewClientViewControllerDelegate.swift
//  Check_Clients
//
//  Created by Станислав on 14.04.2022.
//

protocol ReloadClientListDelegate: AnyObject {
    func reloadClientList()
}

extension ClientListViewController: ReloadClientListDelegate {
    func reloadClientList() {
        // TODO: Заменит на метод, который обновляет по индексу добавленной ячейки,
        // TODO: если такое возможно
        tableView.reloadData()
    }
}
