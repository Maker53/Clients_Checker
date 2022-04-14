//
//  ClientListViewController + NewClientViewControllerDelegate.swift
//  Check_Clients
//
//  Created by Станислав on 14.04.2022.
//

import Foundation

protocol NewClientViewControllerDelegate: AnyObject {
    func getClient(client: Client)
}

extension ClientListViewController: NewClientViewControllerDelegate {
    func getClient(client: Client) {
        clients.append(client)
        
        // TODO: Заменит на метод, который обновляет по индексу добавленной ячейки,
        // TODO: если такое возможно
        tableView.reloadData()
    }
}
