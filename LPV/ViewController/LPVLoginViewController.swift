//
//  LoginViewController.swift
//  GedditChallenge
//
//  Created by Chace Teera on 17/02/2020.
//  Copyright © 2020 chaceteera. All rights reserved.
//

import UIKit
import Alamofire



public class LPVLoginViewController: UIViewController {
    
    /// The current content view controller (shown behind the drawer).
    public fileprivate(set) var initialVC: UIViewController!
    public fileprivate(set) var productDetailVC: UIViewController!

    required public init(initialViewController: UIViewController, productDetailViewController: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        
        ({
            self.initialVC = initialViewController
            self.productDetailVC = productDetailViewController
        })()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    lazy var emailFieldWithLabel: TextFieldWithLabel = {
        let view = TextFieldWithLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var passwordFieldWithLabel: TextFieldWithLabel = {
        let view = TextFieldWithLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.layer.cornerRadius = 5
        button.backgroundColor = .black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.setTitle("Login", for: .normal)
        button.tintColor = .white
        return button
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        overrideUserInterfaceStyle = .light
        setupViews()

        

        // Do any additional setup after loading the view.
    }

    @objc func handleLogin(_ sender: UIButton) {
        
        guard let email = emailFieldWithLabel.textField.text, let password = passwordFieldWithLabel.textField.text else { return }
        
        NetworkService.shared.signIn(email: email, password: password) { (error) in
            if let error = error {

            let alertController = UIAlertController(title: error.localizedDescription, message: "Email or password is incorrect", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(okayAction)
            self.present(alertController, animated: true, completion: nil)

            return
            }
            
            let primaryVC = PrimaryContentViewController()
            primaryVC.initialVC = self.initialVC
            let drawerVC = DrawerViewController()
            drawerVC.productDetailVC = self.productDetailVC

            guard let window = UIApplication.shared.keyWindow else {
                return
            }

            let vc = ProductViewController(contentViewController: primaryVC, drawerViewController: drawerVC)
            // Set the new rootViewController of the window.
            // Calling "UIView.transition" below will animate the swap.
            window.rootViewController = vc

            // A mask of options indicating how you want to perform the animations.
            let options: UIView.AnimationOptions = .transitionCrossDissolve

            // The duration of the transition animation, measured in seconds.
            let duration: TimeInterval = 0.3

            // Creates a transition animation.
            // Though `animations` is optional, the documentation tells us that it must not be nil. ¯\_(ツ)_/¯
            UIView.transition(with: window, duration: duration, options: options, animations: {}, completion:
            { completed in
                
                // maybe do something on completion here
            })

        }
    }
    

    
}

