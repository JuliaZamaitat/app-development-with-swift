//
//  IntermediaryModels.swift
//  Restaurant
//
//  Created by Julia Zamaitat on 13.08.19.
//  Copyright © 2019 Julia Zamaitat. All rights reserved.
//

import Foundation

struct Categories: Codable {
    let categories: [String]
}

struct PreparationTime: Codable {
    let prepTime: Int
    
    enum CodingKeys: String, CodingKey{
        case prepTime = "preparation_time"
    }
}


