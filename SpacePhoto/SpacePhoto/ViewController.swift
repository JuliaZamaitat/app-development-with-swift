//
//  ViewController.swift
//  SpacePhoto
//
//  Created by Julia Zamaitat on 09.08.19.
//  Copyright © 2019 Julia Zamaitat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
  
    let photoInfoController = PhotoInfoController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*scrollView.contentLayoutGuide.bottmAnchor.constraint(equalTo: label.bottomAnchor).isActive = true*/
        
        descriptionLabel.text = ""
        copyrightLabel.text = ""
        photoInfoController.fetchPhotoInfo { (photoInfo) in
            if let photoInfo = photoInfo {
                DispatchQueue.main.async {
                self.title = photoInfo.title
                self.descriptionLabel.text = photoInfo.description
                if let copyright = photoInfo.copyright {
                    self.copyrightLabel.text = "Copyright \(copyright)"
                    
                    
                } else {
                    self.copyrightLabel.isHidden = true
                }
            }
            }
            
        }
        
    }


}

