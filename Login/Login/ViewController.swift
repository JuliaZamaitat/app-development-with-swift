//
//  ViewController.swift
//  Login
//
//  Created by Julia Zamaitat on 29.07.19.
//  Copyright © 2019 Julia Zamaitat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
   
    
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var forgotUsernameButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sender = sender as? UIButton else {return}
        if sender == forgotUsernameButton {
        segue.destination.navigationItem.title = "Forgot Username"
        } else if sender == forgotPasswordButton {
            segue.destination.navigationItem.title = "Forgot Password"
        } else {
            segue.destination.navigationItem.title = userName.text
        }
    }
    
    
    @IBAction func usernameForgotten(_ sender: Any) {
        performSegue(withIdentifier: "Landing" , sender: forgotUsernameButton)
        
    }
    
    @IBAction func passwordForgotten(_ sender: Any) {
         performSegue(withIdentifier: "Landing" , sender: forgotPasswordButton)
    }
}

