//
//  NewClientViewController.swift
//  Check_Clients
//
//  Created by Станислав on 14.04.2022.
//

import UIKit

class NewClientViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    @objc func cancelBarButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func saveBarButtonTapped() {
        
    }
}
