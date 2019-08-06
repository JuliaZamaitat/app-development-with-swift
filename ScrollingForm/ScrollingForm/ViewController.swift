//
//  ViewController.swift
//  ScrollingForm
//
//  Created by Julia Zamaitat on 31.07.19.
//  Copyright © 2019 Julia Zamaitat. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var textFields: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in self.textFields{
                i.delegate = self
            
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        for i in textFields{
        i.resignFirstResponder()
        }
        return true
    }
    
    
}

