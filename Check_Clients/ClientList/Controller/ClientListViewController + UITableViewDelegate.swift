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
            var allData: [String : [Client]]
            var visitTimes: [String]
            
            if isFiltering {
                allData = getData(from: filteredClients).allData ?? [:]
                visitTimes = getData(from: filteredClients).visitTimes ?? []
            } else {
                allData = getData(from: clients).allData ?? [:]
                visitTimes = getData(from: clients).visitTimes ?? []
            }
            
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
        var client: Client?
        
        if isFiltering {
            client = getClientBy(from: filteredClients, indexPath: indexPath)
        } else {
            client = getClientBy(from: clients, indexPath: indexPath)
        }
        
        let newClientViewController = NewClientViewController()
        let newClientNavigationController =  UINavigationController(
            rootViewController: newClientViewController)
        
        newClientViewController.delegate = self
        newClientViewController.currentClient = client
        
        present(newClientNavigationController, animated: true)
    }
}
