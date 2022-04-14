//
//  ClientCell.swift
//  Check_Clients
//
//  Created by Станислав on 13.04.2022.
//

import UIKit

class ClientCell: UITableViewCell {
    // MARK: - Identifier
    static let identifier = String(describing: ClientCell.self)
    
    // MARK: - Public Properties
    lazy var checkMark: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 24)
        
        return label
    }()
    lazy var clientName = UILabel()
    lazy var location = UILabel()
    lazy var visitTime = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupClientCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Client Cell
extension ClientCell {
    private func setupClientCell() {
        checkMark.text = "✅"
        clientName.text = "Namdagsdggsdgsdsdgsdgsdgsdgse"
        location.text = "Location"
        visitTime.text = "18:00"
        
        let stackView = UIStackView(arrangedSubviews: [clientName, location])
        
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        checkMark.translatesAutoresizingMaskIntoConstraints = false
        visitTime.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(checkMark)
        contentView.addSubview(stackView)
        contentView.addSubview(visitTime)
        
        NSLayoutConstraint.activate([
            checkMark.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            checkMark.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: checkMark.trailingAnchor, constant: 15),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: visitTime.leadingAnchor, constant: -15),
            visitTime.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            visitTime.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            visitTime.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}
