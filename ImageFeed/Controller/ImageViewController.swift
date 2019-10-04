//
//  ImageViewController.swift
//  ImageFeed
//
//  Created by Aukmate  Chayapiwat on 5/6/2562 BE.
//  Copyright © 2562 Aukmate  Chayapiwat. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController,UIScrollViewDelegate{

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var myImage: UIImageView!
    var newImage : UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        myImage.image = newImage
        configureScrollView()
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return myImage
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if myImage.frame.height <= scrollView.frame.height {
            let shiftHeight = scrollView.frame.height/2.0 - scrollView.contentSize.height/2.0
            scrollView.contentInset.top = shiftHeight
        }
        if myImage.frame.width <= scrollView.frame.width {
            let shiftWidth = scrollView.frame.width/2.0 - scrollView.contentSize.width/2.0
                scrollView.contentInset.left = shiftWidth
        }
        
        print("frame width:\(myImage.frame.size.width) height:\(myImage.frame.size.height)")
        print("bound width:\(scrollView.bounds.width) bound:\(scrollView.bounds.height)")
        print("width \(myImage.frame.height)")
    }

    func configureScrollView(){
        scrollView.delegate = self
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 10.0
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bouncesZoom = true
        
    }
}
