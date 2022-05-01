//
//  SetupNewClientViewController.swift
//  Check_Clients
//
//  Created by Станислав on 14.04.2022.
//

import UIKit

extension NewClientViewController {
    func setupUI() {
        cancelBarButton = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelBarButtonTapped)
        )
        
        saveBarButton = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveBarButtonTapped)
        )
        saveBarButton.isEnabled = false
        
        title = "Новый клиент"
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = cancelBarButton
        navigationItem.rightBarButtonItem = saveBarButton
        
        setupTextFields()
    }
    
    func setupEditScreen() {
        if let currentClient = currentClient {
            clientNameTF.text = currentClient.clientName
            locationTF.text = currentClient.location
            visitTimeDatePicker.date = currentClient.visitTime
            saveBarButton.isEnabled = true
            title = currentClient.clientName
        }
    }
    
    private func setupTextFields() {
        let stackView = UIStackView(arrangedSubviews: [clientNameTF, locationTF])
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 25
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        clientNameTF.placeholder = "Имя клиента"
        clientNameTF.clearButtonMode = .whileEditing
        clientNameTF.autocapitalizationType = .words
        clientNameTF.autocorrectionType = .no
        clientNameTF.borderStyle = .roundedRect
        clientNameTF.returnKeyType = .next
        clientNameTF.delegate = self
        
        locationTF.placeholder = "Место приема"
        locationTF.clearButtonMode = .whileEditing
        locationTF.autocorrectionType = .no
        locationTF.borderStyle = .roundedRect
        locationTF.returnKeyType = .done
        locationTF.delegate = self
        
        visitTimeDatePicker.locale = Locale(identifier: "Ru_ru")
        visitTimeDatePicker.datePickerMode = .dateAndTime
        visitTimeDatePicker.minuteInterval = 10
        visitTimeDatePicker.contentHorizontalAlignment = .left
        visitTimeDatePicker.translatesAutoresizingMaskIntoConstraints = false
        
        [clientNameTF, locationTF].forEach {
            $0.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        }
        
        view.addSubview(stackView)
        view.addSubview(visitTimeDatePicker)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            stackView.heightAnchor.constraint(equalToConstant: 115),
            visitTimeDatePicker.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 25),
            visitTimeDatePicker.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            visitTimeDatePicker.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
    }
}
