//
//  ViewController.swift
//  Contest
//
//  Created by Julia Zamaitat on 08.08.19.
//  Copyright © 2019 Julia Zamaitat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func submitButtonPressed(_ sender: Any) {
       
       if let email = emailTextField.text, !email.isEmpty {
            performSegue(withIdentifier: "submitSegue", sender: nil)
        } else {
            shakeTextField()
            }
        }
    
    func shakeTextField() {
        UIView.animate(withDuration: 0.1, animations: {
            let translationRight = CGAffineTransform(translationX: 10, y: 0)
            self.emailTextField.transform = translationRight
        }) { (_) in
            UIView.animate(withDuration: 0.1, animations: {
                let translationLeft = CGAffineTransform(translationX: -20, y: 0)
                self.emailTextField.transform = translationLeft
            }, completion: { (_) in
                self.emailTextField.transform = CGAffineTransform.identity
            })
        }
    }
}
    


