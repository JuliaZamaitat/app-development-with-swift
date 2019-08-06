//
//  ViewController.swift
//  ISpy
//
//  Created by Julia Zamaitat on 31.07.19.
//  Copyright © 2019 Julia Zamaitat. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollViewView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollViewView.delegate = self
        updateZoomFor(size: view.bounds.size)
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    func updateZoomFor(size: CGSize){
        let widthScale = size.height / imageView.bounds.height
        let heightScale = size.height / imageView.bounds.height
        let scale = min(widthScale, heightScale)
        scrollViewView.minimumZoomScale = scale
    }
}

