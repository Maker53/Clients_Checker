//
//  Client.swift
//  Check_Clients
//
//  Created by Станислав on 14.04.2022.
//

import Foundation

struct Client {
    var clientName: String
    var location: String
    var visitTime: Date
    
    static let mock = [
        Client(clientName: "Alyona", location: "Saint-Petersburg", visitTime: Date()),
        Client(clientName: "Stanislav Shalgin", location: "Saint-Petersburg", visitTime: Date()),
        Client(clientName: "Dmitriy G.", location: "Saint-Petersburg", visitTime: Date()),
        Client(clientName: "Dmitriy P.", location: "Saint-Petersburg", visitTime: Date())
    ]
}
