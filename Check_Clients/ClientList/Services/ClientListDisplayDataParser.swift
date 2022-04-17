//
//  ClientListDisplayDataParser.swift
//  Check_Clients
//
//  Created by Станислав on 17.04.2022.
//

import Foundation

class ClientListDisplayDataParser {
    static let shared = ClientListDisplayDataParser()
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.setLocalizedDateFormatFromTemplate("HH:mm")
        
        return dateFormatter
    }()
    
    private init() {}
    
    func getDisplayData(from client: Client) -> DisplayData {
        var isDone = ""
        
        let time = dateFormatter.string(from: client.visitTime)
        
        if client.isDone {
            // TODO: Добавить кастомизацию ячейки, при разных ее состояниях (закончена встреча или нет)
            isDone = "✅"
        } else {
            isDone = "⬜️"
        }
        
        return DisplayData(
            clientName: client.clientName,
            location: client.location,
            visitTime: time,
            isDone: isDone
        )
    }
}

class DisplayData {
    var clientName: String
    var location: String
    var visitTime: String
    var isDone: String
    
    init(clientName: String, location: String, visitTime: String, isDone: String) {
        self.clientName = clientName
        self.location = location
        self.visitTime = visitTime
        self.isDone = isDone
    }
}
