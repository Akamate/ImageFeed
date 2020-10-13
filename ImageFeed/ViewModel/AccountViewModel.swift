//
//  AccountViewModel.swift
//  ImageFeed
//
//  Created by Aukmate  Chayapiwat on 7/6/2562 BE.
//  Copyright © 2562 Aukmate  Chayapiwat. All rights reserved.
//

import Foundation
import RealmSwift
import KeychainAccess

final class AccountViewModel {
    private var loggedUsername : String = ""
    private var loggedPassword : String = ""
    
    func saveAccount(userName: String, password: String) {
        do {
            try Keychain().set(password, key: userName)
        } catch {
            print(error)
        }
    }
    
    func checkLoginComplete(userName: String, password: String) -> Bool{
        do {
            let pass = try Keychain().get(userName)
            if(pass == password){
                return true
            }
            else{
                return false
            }
        } catch {
            print(error)
            return false
        }
    }
    
    func getPassword(userName : String) -> String {
        do {
            let pass = try Keychain().get(userName)
            return pass!
        } catch {
            print(error)
            return "not found"
        }
    }
}
