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
    // TODO: Добавить свойство с типом бул, которое будет отображать оконченные сессии
    
    init(clientName: String, location: String, visitTime: Date) {
        self.clientName = clientName
        self.location = location
        self.visitTime = visitTime
    }
}
