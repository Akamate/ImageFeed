//
//  ImageList.swift
//  ImageFeed
//
//  Created by Aukmate  Chayapiwat on 10/6/2562 BE.
//  Copyright © 2562 Aukmate  Chayapiwat. All rights reserved.
//

import Foundation
import RealmSwift

class ImageList : Object {
    var list = List<ImageFeed>()
}
