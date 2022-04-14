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
    // TODO: Поменять на DatePicker
    lazy var visitTimeTF = UITextField()
    
    // MARK: - Public Properties
    var newClient: Client?
    var delegate: NewClientViewControllerDelegate!
    
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
            visitTime: Date()
        )
        
        delegate.getClient(client: newClient!)
        dismiss(animated: true)
    }
    
    // MARK: - Text Fields Action
    @objc func textFieldChanged(_ sender: UITextField) {
        guard
            let inputName = clientNameTF.text,
            let inputLocation = locationTF.text,
            let inputTime = visitTimeTF.text
        else { return }
        
        if inputName.isEmpty || inputLocation.isEmpty || inputTime.isEmpty {
            saveBarButton.isEnabled = false
            return
        }
        
        saveBarButton.isEnabled = true
    }
}
