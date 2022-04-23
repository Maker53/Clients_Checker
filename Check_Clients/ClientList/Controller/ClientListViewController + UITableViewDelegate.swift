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
            let section = IndexSet(integer: indexPath.section)
            guard let allData = getData().allData else { return }
            guard let visitTimes = getData().visitTimes else { return }
            let clientsInDay = allData[visitTimes[indexPath.section]]
            guard let client = clientsInDay?[indexPath.row] else { return }
            
            StorageManager.delete(client)
            
            if clientsInDay?.count == 1 {
                tableView.deleteSections(section, with: .automatic)
            } else {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        guard let client = getClientBy(indexPath: indexPath) else { return }
        
        let newClientViewController = NewClientViewController()
        let newClientNavigationController =  UINavigationController(
            rootViewController: newClientViewController)
        
        newClientViewController.delegate = self
        newClientViewController.currentClient = client
        
        present(newClientNavigationController, animated: true)
    }
}
