//
//  Client.swift
//  Check_Clients
//
//  Created by Станислав on 14.04.2022.
//

import RealmSwift

class Client: Object {
    @Persisted var clientName: String
    @Persisted var location: String
    @Persisted var visitTime: Date
    @Persisted var isDone = false
    
    convenience init(clientName: String, location: String, visitTime: Date) {
        self.init()
        self.clientName = clientName
        self.location = location
        self.visitTime = visitTime
    }
}
