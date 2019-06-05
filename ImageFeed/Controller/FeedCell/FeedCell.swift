//
//  FeedCell.swift
//  ImageFeed
//
//  Created by Aukmate  Chayapiwat on 4/6/2562 BE.
//  Copyright © 2562 Aukmate  Chayapiwat. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet var myImage: UIImageView!
    @IBOutlet var date: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setImage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setImage(){
        let screenSize = UIScreen.main.bounds
        myImage.widthAnchor.constraint(equalToConstant: screenSize.width/2).isActive = true
        //myImage.heightAnchor.constraint(equalToConstant: screenSize.height/2).isActive = true
    }
    
}
