//
//  AccountViewModel.swift
//  ImageFeed
//
//  Created by Aukmate  Chayapiwat on 7/6/2562 BE.
//  Copyright © 2562 Aukmate  Chayapiwat. All rights reserved.
//

import Foundation
import RealmSwift

class AccountViewModel {
    let realm = try! Realm()
    var accounts : Results<Account>?
    var loggedUsername : String = ""
    var loggedPassword : String = ""
    func saveAccount(userName : String, password : String){
        let account = Account()
        account.userName = userName
        account.password = password
        do {
            try realm.write {
                realm.add(account)
            }
        }
        catch{
            print(error)
        }
        
    }
    func fetchAccount(){
        accounts = realm.objects(Account.self)
    }
    func checkLoginComplete(userName : String, password : String){
        
    }
}
