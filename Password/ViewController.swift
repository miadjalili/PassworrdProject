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
    }
    func layout(){
        stackView.addSubview(newPasswordTextField)
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            newPasswordTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1.0),
            newPasswordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter:newPasswordTextField.trailingAnchor, multiplier: 1.0)
        ])
        
    }
}
