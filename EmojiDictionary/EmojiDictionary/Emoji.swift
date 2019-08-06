//
//  Emoji.swift
//  EmojiDictionary
//
//  Created by Julia Zamaitat on 31.07.19.
//  Copyright © 2019 Julia Zamaitat. All rights reserved.
//

import Foundation

class Emoji {
    var symbol: String
    var name: String
    var description: String
    var usage: String
    
    init(symbol: String, name: String, description: String, usage: String){
        self.symbol = symbol
        self.name = name
        self.description = description
        self.usage = usage
    }
}
