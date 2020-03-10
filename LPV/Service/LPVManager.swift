//
//  ProductService.swift
//  GedditChallenge
//
//  Created by Chace Teera on 10/03/2020.
//  Copyright © 2020 chaceteera. All rights reserved.
//

import Foundation

public class LPVManager {

    public static let shared = LPVManager()

    public var onSelected: ((_ product: LPVProduct) -> ())?

}
