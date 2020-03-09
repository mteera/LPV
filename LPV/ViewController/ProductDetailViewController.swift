//
//  ProductDetailViewController.swift
//  GedditChallenge
//
//  Created by Chace Teera on 08/03/2020.
//  Copyright © 2020 chaceteera. All rights reserved.
//

import UIKit
import Kingfisher


class ProductDetailViewController: UIViewController {
    var product: Product? {
        didSet {

            if let image = product?.attributes.image {
                let url = URL(string: image)
                productImageView.kf.setImage(with: url)
                
            }
            
        }
    }
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "close"), for: .normal)
        button.tintColor = UIColor.black
        return button
    }()
    
    
    lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 250, green: 248, blue: 246, alpha: 1)
        view.addSubview(productImageView)
        productImageView.fillSuperview()
        
        view.addSubview(closeButton)
        closeButton.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, topConstant: 15, leftConstant: 15, widthConstant: 50, heightConstant: 50)
        closeButton.addTarget(self, action: #selector(handleDismiss(_:)), for: .touchUpInside)

    }
    
    @objc func handleDismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {
            // Callback to inform when detail view is dismissed
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "detailDismiss"), object: nil)
        })
    }
}
