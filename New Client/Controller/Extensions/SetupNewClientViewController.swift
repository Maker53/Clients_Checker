//
//  SetupNewClientViewController.swift
//  Check_Clients
//
//  Created by Станислав on 14.04.2022.
//

import UIKit

extension NewClientViewController {
    func setupUI() {
        let cancelBarButton = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelBarButtonTapped)
        )
        
        let saveBarButton = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveBarButtonTapped)
        )
        
        title = "New Client"
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = cancelBarButton
        navigationItem.rightBarButtonItem = saveBarButton
        
        setupTextFields()
    }
    
    private func setupTextFields() {
        let clientNameTF = UITextField()
        let locationTF = UITextField()
        let visitTimeTF = UITextField()
        let stackView = UIStackView(arrangedSubviews: [clientNameTF, locationTF, visitTimeTF])
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 25
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        clientNameTF.placeholder = "Client name"
        clientNameTF.borderStyle = .roundedRect
        locationTF.placeholder = "Location"
        locationTF.borderStyle = .roundedRect
        visitTimeTF.placeholder = "Visit time"
        visitTimeTF.borderStyle = .roundedRect
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            stackView.heightAnchor.constraint(equalToConstant: 165)
        ])
    }
}
