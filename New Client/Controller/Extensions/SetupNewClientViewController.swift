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
    }
}
