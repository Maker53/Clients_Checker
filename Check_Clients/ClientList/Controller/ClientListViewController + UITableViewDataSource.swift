//
//  ClientListViewController + UITableViewDataSource.swift
//  Check_Clients
//
//  Created by Станислав on 13.04.2022.
//

import UIKit

extension ClientListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        getData().visitTimes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        getData().visitTimes?[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let allData = getData().allData
        let visitTimes = getData().visitTimes
        return allData?[visitTimes?[section] ?? ""]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ClientCell.identifier, for: indexPath)
        guard let cell = cell as? ClientCell else { return cell }
        
        guard let client = getClientBy(indexPath: indexPath) else { return cell }
                
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
