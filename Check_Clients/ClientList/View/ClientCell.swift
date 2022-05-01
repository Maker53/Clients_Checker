//
//  ClientCell.swift
//  Check_Clients
//
//  Created by Станислав on 13.04.2022.
//

import UIKit

class ClientCell: UITableViewCell {
    // MARK: - Public UI Properties
    lazy var checkMarkLabel: UILabel = {
        let label = UILabel()
        
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 24)
        label.addGestureRecognizer(tap)
        
        return label
    }()
    lazy var clientNameLabel = UILabel()
    lazy var locationLabel = UILabel()
    lazy var visitTimeLabel = UILabel()
    
    // MARK: - Public Properties
    static let identifier = String(describing: ClientCell.self)
    lazy var doneTapAction: ((CGPoint) -> Void) = { _ in }
    
    // MARK: - Private Properties
    private lazy var tap = UITapGestureRecognizer(target: self, action: #selector(doneAction))
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupClientCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure the cell method
    func configure(with client: Client) {
        let displayData = ClientListDisplayDataParser.shared.getDisplayDataForCell(from: client)
        
        clientNameLabel.text = displayData.clientName
        locationLabel.text = displayData.location
        visitTimeLabel.text = displayData.visitTime
        checkMarkLabel.text = displayData.isDone
    }
    
    // MARK: - Private @objc action for checkMark label
    @objc private func doneAction() {
        let tapLocation = tap.location(in: checkMarkLabel)
        doneTapAction(tapLocation)
    }
}

// MARK: - Setup Client Cell
extension ClientCell {
    private func setupClientCell() {
        let stackView = UIStackView(arrangedSubviews: [clientNameLabel, locationLabel])
        
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        checkMarkLabel.translatesAutoresizingMaskIntoConstraints = false
        visitTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(checkMarkLabel)
        contentView.addSubview(stackView)
        contentView.addSubview(visitTimeLabel)
        
        NSLayoutConstraint.activate([
            checkMarkLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            checkMarkLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkMarkLabel.widthAnchor.constraint(equalToConstant: 30),
            stackView.leadingAnchor.constraint(equalTo: checkMarkLabel.trailingAnchor, constant: 15),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: visitTimeLabel.leadingAnchor, constant: -15),
            visitTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            visitTimeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            visitTimeLabel.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}
