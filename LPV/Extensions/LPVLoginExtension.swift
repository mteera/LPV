//
//  LPVLoginViewController.swift
//  GedditChallenge
//
//  Created by Chace Teera on 10/03/2020.
//  Copyright © 2020 chaceteera. All rights reserved.
//

import UIKit


extension LPVLoginController {

    func setupViews() {
        emailFieldWithLabel.titleLabel.text = "Email"
        emailFieldWithLabel.textField.placeholder = "someone@example.com"

        passwordFieldWithLabel.titleLabel.text = "Password"
        passwordFieldWithLabel.textField.isSecureTextEntry = true

        let stackView = UIStackView(arrangedSubviews: [emailFieldWithLabel, passwordFieldWithLabel, loginButton])
        stackView.spacing = 40
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)
        stackView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 40, leftConstant: 32, bottomConstant: 0, rightConstant: 32)
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.addTarget(self, action: #selector(handleLogin(_:)), for: .touchUpInside)
    }
    
    
}
