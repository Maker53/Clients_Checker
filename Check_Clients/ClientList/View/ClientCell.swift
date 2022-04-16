//
//  ClientCell.swift
//  Check_Clients
//
//  Created by Станислав on 13.04.2022.
//

import UIKit

class ClientCell: UITableViewCell {
    // MARK: - Public UI Properties
    lazy var checkMark: UILabel = {
        let label = UILabel()
        
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 24)
        label.addGestureRecognizer(tap)
        
        return label
    }()
    lazy var clientName = UILabel()
    lazy var location = UILabel()
    lazy var visitTime = UILabel()
    
    // MARK: - Public Properties
    static let identifier = String(describing: ClientCell.self)
    var doneTapAction: ((CGPoint) -> Void)?
    
    // MARK: - Private Properties
    private lazy var tap = UITapGestureRecognizer(target: self, action: #selector(doneAction))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // TODO: Как бы от этого избавиться?
        doneTapAction?(.zero)
        setupClientCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with client: Client) {
        clientName.text = client.clientName
        location.text = client.location
        visitTime.text = client.visitTime.description
        if client.isDone {
            // TODO: Добавить кастомизацию ячейки, при разных ее состояниях (закончена встреча или нет)
            checkMark.text = "✅"
        } else {
            checkMark.text = "⬜️"
        }
    }
    
    @objc private func doneAction() {
        let tapLocation = tap.location(in: checkMark)
        doneTapAction?(tapLocation)
    }
}

// MARK: - Setup Client Cell
extension ClientCell {
    private func setupClientCell() {
        checkMark.text = "⬜️"
        
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
