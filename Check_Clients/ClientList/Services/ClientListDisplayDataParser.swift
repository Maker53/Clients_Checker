//
//  ClientListDisplayDataParser.swift
//  Check_Clients
//
//  Created by Станислав on 17.04.2022.
//

import RealmSwift

class ClientListDisplayDataParser {
    static let shared = ClientListDisplayDataParser()
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        return dateFormatter
    }()
    
    private init() {}
    
    func getData(from clients: Results<Client>!) -> DisplayData {
        dateFormatter.setLocalizedDateFormatFromTemplate("dd MMM")
        
        let sortedData = clients.sorted(by: { $0.visitTime < $1.visitTime })
        let data: [String: [Client]] = sortedData.reduce(into: [:]) { partialResult, client in
            guard let _ = partialResult[dateFormatter.string(from: client.visitTime)] else {
                partialResult[dateFormatter.string(from: client.visitTime)] = [client]
                return
            }
            partialResult[dateFormatter.string(from: client.visitTime)]! += [client]
        }
        
        let sortedVisitTimes = data.keys.sorted()
        
        return DisplayData(allData: data, visitTimes: sortedVisitTimes)
    }
    
    func getDisplayData(from client: Client?) -> DisplayData {
        guard let client = client else {
            return DisplayData(clientName: "", location: "", visitTime: "", isDone: "")
        }

        var isDone = ""
        
        dateFormatter.setLocalizedDateFormatFromTemplate("HH:mm")
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
    var clientName: String?
    var location: String?
    var visitTime: String?
    var isDone: String?
    
    var allData: [String: [Client]]?
    var visitTimes: [String]?
    
    init(clientName: String, location: String, visitTime: String, isDone: String) {
        self.clientName = clientName
        self.location = location
        self.visitTime = visitTime
        self.isDone = isDone
    }
    
    init(allData: [String: [Client]], visitTimes: [String]) {
        self.allData = allData
        self.visitTimes = visitTimes
    }
}
