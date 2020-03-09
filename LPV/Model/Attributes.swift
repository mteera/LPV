//
//  Attributes.swift
//  GedditChallenge
//
//  Created by Chace Teera on 03/03/2020.
//  Copyright © 2020 chaceteera. All rights reserved.
//

import Foundation

struct Attributes: Decodable {
    let title: String
    let description: String?
    let price: Int?
    let image: String?

}
