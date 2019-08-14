//
//  Order.swift
//  Restaurant
//
//  Created by Julia Zamaitat on 13.08.19.
//  Copyright © 2019 Julia Zamaitat. All rights reserved.
//

import Foundation

struct Order: Codable {
    var menuItems: [MenuItem]
    
    init(menuItems: [MenuItem] = []){
        self.menuItems = menuItems
    }
}
