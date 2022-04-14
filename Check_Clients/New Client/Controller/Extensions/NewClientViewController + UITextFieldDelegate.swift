//
//  NewClientViewController + UITextFieldDelegate.swift
//  Check_Clients
//
//  Created by Станислав on 14.04.2022.
//

import UIKit

extension NewClientViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case clientNameTF:
            locationTF.becomeFirstResponder()
            return true
        case locationTF:
            visitTimeTF.becomeFirstResponder()
            return true
        default:
            textField.resignFirstResponder()
            return true
        }
    }
}
