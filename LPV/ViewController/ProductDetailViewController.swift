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
            guard let product = product else { return }
            if let image = product.attributes.image {
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

        // Callback function to listen for when product is selected from the SDK
        LPVManager.shared.onSelected = { [weak self] (product) in
            self?.product = product
        }
    }
    

    @objc func handleDismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
