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
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        photoInfoController.fetchPhotoInfo { (photoInfo) in
            if let photoInfo = photoInfo {
               self.updateUI(with: photoInfo)
            }
        }
        
    }
    
    func updateUI(with photoInfo: PhotoInfo) {
        
        let task = URLSession.shared.dataTask(with: photoInfo.url, completionHandler: {
            (data, respone, error) in
                if let data = data,
                    let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        
                        self.title = photoInfo.title
                        self.imageView.image = image
                        self.descriptionLabel.text = photoInfo.description
                        
                        if let copyright = photoInfo.copyright {
                            self.copyrightLabel.text = "Copyright \(copyright)"
                        } else {
                            self.copyrightLabel.isHidden = true
                        }
                         UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    }
            }
        })
        task.resume()
    }


}

