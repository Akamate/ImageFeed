//
//  AccountViewController.swift
//  ImageFeed
//
//  Created by Aukmate  Chayapiwat on 7/6/2562 BE.
//  Copyright © 2562 Aukmate  Chayapiwat. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    lazy var accountVM : AccountViewModel = {
        return AccountViewModel()
    }()
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(LoggedUser.loggedUserName)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
        self.tabBarController?.navigationItem.title = "Change Password"
        self.userName.text = LoggedUser.loggedUserName
    }
    
    @IBAction func confirmPressed(_ sender: Any) {
        if(oldPassword.text != "" && newPassword.text != "" && confirmPassword.text != ""){
            if(oldPassword.text == LoggedUser.loggedPassword){
                if(newPassword == confirmPassword){
                    accountVM.saveAccount(userName: userName.text!, password: newPassword.text!)
                }
            }
        }
    }
}
