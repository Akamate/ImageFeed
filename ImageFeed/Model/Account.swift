//
//  Account.swift
//  ImageFeed
//
//  Created by Aukmate  Chayapiwat on 7/6/2562 BE.
//  Copyright © 2562 Aukmate  Chayapiwat. All rights reserved.
//

import Foundation
import RealmSwift

class Account:Object {
    @objc dynamic var userName : String = ""
    @objc dynamic var password : String = ""
}
