//
//  PrimaryContentViewControllerExtension.swift
//  GedditChallenge
//
//  Created by Chace Teera on 05/03/2020.
//  Copyright © 2020 chaceteera. All rights reserved.
//

import UIKit
import AVKit

extension PrimaryContentViewController {
    
    func setupProductAction() {
        view.addSubview(productListButtonContainer)
        productListButtonContainer.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 15), size: CGSize(width: 50, height: 50))
        
        productListButtonContainer.addSubview(productListButton)
        productListButton.fillSuperview(padding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        
        view.addSubview(closeButton)
        closeButton.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, topConstant: 15, leftConstant: 15, widthConstant: 50, heightConstant: 50)
        
        
    }
    
    func setupLiveViews() {
        view.addSubview(liveContainer)
        liveContainer.anchor(closeButton.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, topConstant: 20, leftConstant: 15, bottomConstant: 0, rightConstant: 0, heightConstant: 30)

        liveContainer.addSubview(liveView)
        liveContainer.addSubview(liveLabel)
        
        liveContainer.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        liveView.anchor(left: liveContainer.leftAnchor, leftConstant: 10, widthConstant: 10, heightConstant: 10)
        liveLabel.anchor(nil, left: liveView.rightAnchor, bottom: nil, right: liveContainer.rightAnchor, leftConstant: 4, rightConstant: 10)

        liveView.centerYInSuperview()
        liveLabel.centerYInSuperview()
        
        
        view.addSubview(viewContainer)
        viewContainer.anchor(liveContainer.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 15, bottomConstant: 0, rightConstant: 0, heightConstant: 30)

        
        viewContainer.addSubview(viewSymbol)
        viewContainer.addSubview(viewLabel)
        
        viewContainer.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        viewSymbol.anchor(left: viewContainer.leftAnchor, leftConstant: 10, widthConstant: 20, heightConstant: 20)
        viewLabel.anchor(nil, left: viewSymbol.rightAnchor, bottom: nil, right: viewContainer.rightAnchor, leftConstant: 4, rightConstant: 10)

        viewSymbol.centerYInSuperview()
        viewLabel.centerYInSuperview()
    }
    
    func setupVideoPlayer() {
        let urlString =  "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8"

        guard let url = URL(string: urlString) else { return }


        avPlayer = AVPlayer(url: url)
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        avPlayer.volume = 0
        avPlayer.actionAtItemEnd = .none

        avPlayerLayer.frame = view.layer.bounds
        view.backgroundColor = .systemGray5
        view.layer.insertSublayer(avPlayerLayer, at: 0)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: avPlayer.currentItem)
        
        
        NotificationCenter.default.addObserver(self,
                                           selector: #selector(playerItemDidReachEnd(notification:)),
                                           name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                           object: avPlayer.currentItem)
        
        avPlayer.addObserver(self, forKeyPath: "timeControlStatus", options: [.old, .new], context: nil)

        
        productListButton.addTarget(self, action: #selector(handleOpenCloseDrawer(_:)), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(handleClose(_:)), for: .touchUpInside)

    }
    

    @objc func handleOpenCloseDrawer(_ sender: UIButton) {
        drawerOpen = !drawerOpen
        if drawerOpen {
            self.pulleyViewController?.setDrawerPosition(position: .partiallyRevealed, animated: true)

        } else {
            self.pulleyViewController?.setDrawerPosition(position: .closed, animated: true)

        }
    }
    
    @objc func handleClose(_ sender: UIButton) {
        
        delegate?.didDismiss()
        let vc = self.initialVC
        self.dismiss(animated: false, completion: {
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        })


    }
    
    

    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "timeControlStatus", let change = change, let newValue = change[NSKeyValueChangeKey.newKey] as? Int, let oldValue = change[NSKeyValueChangeKey.oldKey] as? Int {
            let oldStatus = AVPlayer.TimeControlStatus(rawValue: oldValue)
            let newStatus = AVPlayer.TimeControlStatus(rawValue: newValue)
            if newStatus != oldStatus {
                DispatchQueue.main.async {[weak self] in
                    if newStatus == .playing || newStatus == .paused {
                        
                        self?.activityIndicatorView.stopAnimating()
                    }
                }
            }
        }
    }


    @objc func playerItemDidReachEnd(notification: Notification) {
            let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: CMTime.zero)
    }
    
    
    
    
    
}


