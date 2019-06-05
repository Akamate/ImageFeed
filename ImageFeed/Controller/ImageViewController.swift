//
//  ImageViewController.swift
//  ImageFeed
//
//  Created by Aukmate  Chayapiwat on 5/6/2562 BE.
//  Copyright © 2562 Aukmate  Chayapiwat. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet var myImage: UIImageView!
    var newImage : UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        myImage.image = newImage
        // Do any additional setup after loading the view.
    }


}
