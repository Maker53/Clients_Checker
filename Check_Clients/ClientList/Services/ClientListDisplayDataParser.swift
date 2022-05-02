//
//  ClientListDisplayDataParser.swift
//  Check_Clients
//
//  Created by Станислав on 17.04.2022.
//

import RealmSwift

class ClientListDisplayDataParser {
    // MARK: - Public Property
    static let shared = ClientListDisplayDataParser()
    
    // MARK: - Private Properties
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        return dateFormatter
    }()
    
    // MARK: - Private Initializer
    private init() {}
    
    // MARK: - Public Methods
    // Приходится возвращать массив не со стринговыми датами, а с типом Date, так как
    // невозможно сравнить стринговые даты между собой по тому, какая дата идет раньше,
    // а какая позже. Сравнение необходимо для возможности проскролить таблицу при
    // появлении вьюхи до текущей даты или даты, ближайшей к текущей в положительную сторону,
    // либо, если все даты раньше текущей даты, то к ближайшей дате в отрицательную сторону.
    func getGroupedClients(from clients: Results<Client>!) -> [(Date, [Client])] {
        dateFormatter.setLocalizedDateFormatFromTemplate("dd-MMM-YY")
        
        // Сперва, сортируем список клиентов по времени по возрастанию.
        let sortedClientList = clients.sorted { $0.visitTime < $1.visitTime }
        
        // Затем, группируем отсортированный массив клиентов по дате, чтобы получился словарь,
        // в котором на конкретный день будет массив клиентов (уже отсортированных по времени
        // по возрастанию). Форматтер используется для того, чтобы была возможность
        // сгруппировать именно по дням, так как Date группирует в зависимости от минут.
        let groupedClientList = Dictionary(grouping: sortedClientList) { dateFormatter.string(from: $0.visitTime) }
        
        // Нужно преобразовать словарь в упорядоченную коллекцию. Используем для этого
        // массив кортежей.
        let clientList = groupedClientList
        // Группируем кортеж по дате, чтобы в дальнейшем была возможность отсортировать массив.
        // Так как в массиве клиентов все клиенты от одной даты, то нам не важно конкретное время
        // для группировки по дням, поэтому берем первый элемент массива клиентов для простоты.
            .map { ($0.value[0].visitTime, $0.value) }
        // Сортируем список клиентов по дням.
            .sorted { $0.0 < $1.0 }
        
        return clientList
    }
    
    func getDisplayDataForCell(from client: Client) -> DisplayData {
        var isDone: String
        
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

// MARK: - Display Data Class
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
