//
//  ViewController.swift
//  Password
//
//  Created by miadjalili on 5/23/22.
//

import UIKit



import UIKit


class ViewController: UIViewController {
    
    typealias CustomValidation = PasswordTextField.CustomValidation
    let newPasswordTextField = PasswordTextField(placeHolderText: "New Password")
    let stackView = UIStackView()
    let statusView = PasswordStatusView()
    let confirmPasswordTextField = PasswordTextField(placeHolderText: "Re-enter new password")
    let restButton = UIButton(type: .system)
    override func viewDidLoad() {
        setup()
        style()
        layout()
    }
}  

extension ViewController {
    func setup(){
        setupNewPassword()
        setupConfirmPassword()
        setupDismissKeyboardGesture()
    }
    
    private func setupNewPassword(){

        let newPasswordValidation: CustomValidation = { text in
            guard let text = text, !text.isEmpty else {
                self.statusView.rest()
                return (false,"Enter your password")
            }
            self.statusView.updateDisplay(text)
            if !self.statusView.validate(text) {
                return (false,"Your password must meet the requirements below")
            }
            // Valid characters
            let validChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,@:?!()$\\/#"
            let invalidSet = CharacterSet(charactersIn: validChars).inverted
            guard text.rangeOfCharacter(from: invalidSet) == nil else {
                self.statusView.rest()
                return (false, "Enter valid special chars (.,@:?!()$\\/#) with no spaces")
            }
            return(true,"")
        }
        newPasswordTextField.customValidation = newPasswordValidation
        confirmPasswordTextField.delegate = self
    }
    
    private func setupConfirmPassword() {
        let confirmPasswordValidation: CustomValidation = { text in
            guard let text = text, !text.isEmpty else {
                return (false, "Enter your password.")
            }
            
            guard text == self.newPasswordTextField.text else {
                return (false, "Passwords do not match.")
            }
            
            return (true, "")
        }
        confirmPasswordTextField.customValidation = confirmPasswordValidation
           confirmPasswordTextField.delegate = self
    }

   
    
    private func setupDismissKeyboardGesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    
    @objc func viewTapped(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
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
    
    func editingDidEnd(_ sender: PasswordTextField) {
        if sender == newPasswordTextField{
            statusView.shouldRestCriteria = false // add
            _ = newPasswordTextField.validate()
        }
        if sender ==  confirmPasswordTextField {
            _ = confirmPasswordTextField.validate()
        }
    }
    
}
