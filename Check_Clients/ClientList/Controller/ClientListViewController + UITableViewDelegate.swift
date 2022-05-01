//
//  ClientListViewController + UITableViewDelegate.swift
//  Check_Clients
//
//  Created by Станислав on 13.04.2022.
//

import UIKit

extension ClientListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let section = IndexSet(integer: indexPath.section)
            let client: Client
            let clientsInDay: Int
            
            if isFiltering {
                client = getClient(from: filteredClients, indexPath: indexPath)
                clientsInDay = getSortedClients(from: filteredClients)[indexPath.section].clients.count
            } else {
                client = getClient(from: clients, indexPath: indexPath)
                clientsInDay = getSortedClients(from: clients)[indexPath.section].clients.count
            }
            
            DispatchQueue.main.async {
                StorageManager.delete(client)
                
                if clientsInDay == 1 {
                    tableView.deleteSections(section, with: .automatic)
                } else {
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            }            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        var client: Client
        
        if isFiltering {
            client = getClient(from: filteredClients, indexPath: indexPath)
        } else {
            client = getClient(from: clients, indexPath: indexPath)
        }
        
        let newClientViewController = NewClientViewController()
        let newClientNavigationController =  UINavigationController(
            rootViewController: newClientViewController)
        
        newClientViewController.delegate = self
        newClientViewController.currentClient = client
        newClientViewController.setupEditScreen()
        
        present(newClientNavigationController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
