//
//  DrawerViewControllerExtension.swift
//  GedditChallenge
//
//  Created by Chace Teera on 10/03/2020.
//  Copyright © 2020 chaceteera. All rights reserved.
//

import UIKit
import Pulley

extension DrawerViewController {
    func setupTable() {
        view.addSubview(tableView)
        tableView.anchor(top: topView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor
            , padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize())

    }
    
    func setupViews() {
        // A view to indicate to usrs that the element can be dragged
        view.addSubview(topView)
        topView.backgroundColor = .white
        topView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0), size: CGSize(width: view.frame.width, height: 30))
        topView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topView.addSubview(gripperView)
        gripperView.layer.cornerRadius = 2.5
        gripperView.backgroundColor = .systemGray5
        gripperView.anchor(top: topView.topAnchor, leading: nil, bottom: topView.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 10, left: 0, bottom: 5, right: 0), size: CGSize(width: 50, height: 5))
        gripperView.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        gripperTopConstraint = topView.topAnchor.constraint(equalTo: view.topAnchor)
        gripperTopConstraint.isActive = true
        
    }
    
    func fetchData() {
        NetworkService.shared.fetchGenericJSONData(urlString: "https://api.live.dev.gedditlive.com/v1/test/product-list") { (product: ProductData?, error) in
            if let error = error {
                print("Failed to decode reviews:", error)
                return
            }
            guard let products = product?.data else { return }
            self.products = products
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    func registerCells() {
        tableView.register(ProductCell.self, forCellReuseIdentifier: cellId)

    }
}

extension DrawerViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ProductCell else { fatalError() }
        
        let product = self.products[indexPath.row]
        

        cell.product = product
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension DrawerViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let product = self.products[indexPath.row]
        let vc: UIViewController = self.productDetailVC
        // Callback function to listen for when product is selcted from SDK
        vc.view.backgroundColor = .white
        LPVManager.shared.onSelected?(product)
        self.present(vc, animated: true, completion: nil)

        tableView.deselectRow(at: indexPath, animated: true)

    }
}


extension DrawerViewController: PulleyDrawerViewControllerDelegate {

    public func collapsedDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat
    {
        // For devices with a bottom safe area, we want to make our drawer taller. Your implementation may not want to do that. In that case, disregard the bottomSafeArea value.
        return 68.0 + (pulleyViewController?.currentDisplayMode == .drawer ? bottomSafeArea : 0.0)
    }
    
    public func partialRevealDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat
    {
        // For devices with a bottom safe area, we want to make our drawer taller. Your implementation may not want to do that. In that case, disregard the bottomSafeArea value.
        return 464.0 + (pulleyViewController?.currentDisplayMode == .drawer ? bottomSafeArea : 0.0)
    }
    
    public func supportedDrawerPositions() -> [PulleyPosition] {
        return PulleyPosition.all // You can specify the drawer positions you support. This is the same as: [.open, .partiallyRevealed, .collapsed, .closed]
    }
    

}

