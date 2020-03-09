//
//  PrimaryContentViewController.swift
//  GedditChallenge
//
//  Created by Chace Teera on 19/02/2020.
//  Copyright © 2020 chaceteera. All rights reserved.
//

import UIKit
import AVKit
import Pulley


protocol PrimaryContentViewControllerDelegate {
    func didDismiss()
}

class PrimaryContentViewController: UIViewController, AVPlayerViewControllerDelegate {
    // Declare variables
    var delegate: PrimaryContentViewControllerDelegate?
    var avPlayer: AVPlayer!
    var avPlayerLayer: AVPlayerLayer!
    var paused: Bool = false
    var drawerOpen = false
    var initialVC: UIViewController!
    // Declare UI elements
    lazy var productListButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "hanger"), for: .normal)
        button.tintColor = UIColor.black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var productListButtonContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)

        return view
    }()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.color = .darkGray
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "close"), for: .normal)
        button.tintColor = UIColor.white
        return button
    }()
    
    lazy var viewContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var liveContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var liveView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemRed
        return view
    }()
    
    lazy var liveLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "LIVE"
        return label
    }()
    
    
    lazy var viewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "10.2K"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var viewSymbol: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "eye")
        view.tintColor = .white
        return view
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()
        self.activityIndicatorView.startAnimating()

    }

    override func viewDidLoad() {
        overrideUserInterfaceStyle = .light
        self.pulleyViewController?.displayMode = .automatic
        self.pulleyViewController?.setDrawerPosition(position: .closed, animated: false)
        setupViews()
        // Listen for callback to set drawer position when detail view is dismissed
        NotificationCenter.default.addObserver(self, selector: #selector(setDrawerPosition(_:)), name: NSNotification.Name(rawValue: "detailDismiss"), object: nil)
    }
    
    @objc func setDrawerPosition(_ notification: Notification) {
        self.pulleyViewController?.displayMode = .automatic
        self.pulleyViewController?.setDrawerPosition(position: .partiallyRevealed , animated: false)
    }
    
    fileprivate func setupViews() {
        setupProductAction()
        setupLiveViews()
        setupVideoPlayer()
    }
    


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        avPlayer.play()
        paused = false
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        avPlayer.pause()
        paused = true
    }
}


