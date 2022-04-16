//
//  ClientListViewController + NewClientViewControllerDelegate.swift
//  Check_Clients
//
//  Created by Станислав on 14.04.2022.
//

protocol NewClientViewControllerDelegate: AnyObject {
    func addClient()
}

extension ClientListViewController: NewClientViewControllerDelegate {
    func addClient() {
        // TODO: Заменит на метод, который обновляет по индексу добавленной ячейки,
        // TODO: если такое возможно
        tableView.reloadData()
    }
}
