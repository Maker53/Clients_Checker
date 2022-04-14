//
//  NewClientViewController.swift
//  Check_Clients
//
//  Created by Станислав on 14.04.2022.
//

import UIKit

class NewClientViewController: UIViewController {
    
    // MARK: - Public Properties
    lazy var cancelBarButton = UIBarButtonItem()
    lazy var saveBarButton = UIBarButtonItem()
    lazy var clientNameTF = UITextField()
    lazy var locationTF = UITextField()
    lazy var visitTimeTF = UITextField()
    
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
        
    }
}
