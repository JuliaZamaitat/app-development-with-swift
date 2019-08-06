//
//  Registration.swift
//  HotelManzana
//
//  Created by Julia Zamaitat on 06.08.19.
//  Copyright © 2019 Julia Zamaitat. All rights reserved.
//

import Foundation

struct Registration {
    var firstName: String
    var lastName: String
    var emailAddress: String
    
    var checkInDate: Date
    var checkOutDate: Date
    var numberOfAdults: Int
    var numberOfChildren: Int
    
    var roomType: RoomType
    var wifi: Bool
}
