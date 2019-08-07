//
//  ToDoCell.swift
//  ToDoList
//
//  Created by Julia Zamaitat on 07.08.19.
//  Copyright © 2019 Julia Zamaitat. All rights reserved.
//

import UIKit
@objc protocol ToDoCellDelegate: class {
    func checkMarkTapped(sender: ToDoCell)
}

class ToDoCell: UITableViewCell {
    
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var delegate: ToDoCellDelegate?
    
    @IBAction func completeButtonTapped(_ sender: UIButton) {
        delegate?.checkMarkTapped(sender: self)
    }
    
}
