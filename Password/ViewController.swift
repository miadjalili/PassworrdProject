//
//  ViewController.swift
//  Password
//
//  Created by miadjalili on 5/23/22.
//

import UIKit



import UIKit


class ViewController: UIViewController {
    
    let newPasswordTextField = PasswordTextField(placeHolderText: "New Password")
    let stackView = UIStackView()
    let statusView = PasswordStatusView()
    let confirmPasswordTextField = PasswordTextField(placeHolderText: "Re-enter new password")
    let restButton = UIButton(type: .system)
    override func viewDidLoad() {
        style()
        layout()
    }
}  

extension ViewController {
    func style(){
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        newPasswordTextField.delegate = self
       
        statusView.translatesAutoresizingMaskIntoConstraints = false
        statusView.layer.cornerRadius = 5
        statusView.clipsToBounds = true
       
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        restButton.translatesAutoresizingMaskIntoConstraints = false
        restButton.configuration = .filled()
        restButton.setTitle("RestPassword", for: [])
    }
    func layout(){
        
        stackView.addArrangedSubview(newPasswordTextField)
        stackView.addArrangedSubview(statusView)
        stackView.addArrangedSubview(confirmPasswordTextField)
        stackView.addArrangedSubview(restButton)
        view.addSubview(stackView)
        
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2.0),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2.0)
        ])
        
    }
}

extension ViewController : PasswordTextFieldDelegate {
    func editingChanged(_ sender: PasswordTextField) {
        if sender === newPasswordTextField {
            statusView.updateDisplay(sender.textField.text ?? "")
            
        }
    }
    
    
}
