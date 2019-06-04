//
//  ImageFeed.swift
//  ImageFeed
//
//  Created by Aukmate  Chayapiwat on 4/6/2562 BE.
//  Copyright © 2562 Aukmate  Chayapiwat. All rights reserved.
//

import Foundation
import RealmSwift

class ImageFeed : Object {
    @objc dynamic var date : String = ""
    @objc dynamic var myImage :NSData? = nil
}
