//
//  NewClientViewController.swift
//  Check_Clients
//
//  Created by Станислав on 14.04.2022.
//

import UIKit

class NewClientViewController: UIViewController {
    
    // MARK: - UI Properties
    lazy var cancelBarButton = UIBarButtonItem()
    lazy var saveBarButton = UIBarButtonItem()
    lazy var clientNameTF = UITextField()
    lazy var locationTF = UITextField()
    lazy var visitTimeDatePicker = UIDatePicker()
    
    // MARK: - Public Properties
    var newClient: Client!
    var currentClient: Client?
    weak var delegate: ReloadClientListDelegate!
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
    
    // MARK: - Buttons action
    @objc func cancelBarButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func saveBarButtonTapped() {
        newClient = Client(
            clientName: clientNameTF.text!,
            location: locationTF.text!,
            visitTime: visitTimeDatePicker.date
        )
        
        if currentClient != nil {
            DispatchQueue.main.async {
                try! realm.write {
                    self.currentClient?.clientName = self.newClient.clientName
                    self.currentClient?.location = self.newClient.location
                    self.currentClient?.visitTime = self.newClient.visitTime
                    self.delegate.reloadClientList()
                }
            }
        } else {
            DispatchQueue.main.async {
                StorageManager.save(self.newClient)
                self.delegate.reloadClientList()
            }
        }
        dismiss(animated: true)
    }
    
    // MARK: - Text Fields Action
    @objc func textFieldChanged(_ sender: UITextField) {
        guard
            let inputName = clientNameTF.text,
            let inputLocation = locationTF.text
        else { return }
        
        if inputName.isEmpty || inputLocation.isEmpty {
            saveBarButton.isEnabled = false
            return
        }
        
        saveBarButton.isEnabled = true
    }
}
