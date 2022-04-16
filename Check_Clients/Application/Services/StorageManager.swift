//
//  StorageManager.swift
//  Check_Clients
//
//  Created by Станислав on 16.04.2022.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    static func save(_ client: Client) {
        try! realm.write {
            realm.add(client)
        }
    }
}
