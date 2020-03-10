//
//  DrawerViewContoller.swift
//  GedditChallenge
//
//  Created by Chace Teera on 18/02/2020.
//  Copyright © 2020 chaceteera. All rights reserved.
//

import UIKit
import Pulley


public class DrawerViewController: UIViewController {
    
    var cellId = "1234"
    
    var gripperTopConstraint: NSLayoutConstraint!
    public var productDetailVC: UIViewController!

    lazy var topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var gripperView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    fileprivate var drawerBottomSafeArea: CGFloat = 0.0 {
        didSet {
            self.loadViewIfNeeded()
            
            tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: drawerBottomSafeArea, right: 0.0)
        }
    }
    
    var products = [LPVProduct]()

    
    public override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        setupViews()
        registerCells()
        setupTable()
        fetchData()
    }
    

 
}



