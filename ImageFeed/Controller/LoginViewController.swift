//
//  ViewController.swift
//  ImageFeed
//
//  Created by Aukmate  Chayapiwat on 4/6/2562 BE.
//  Copyright © 2562 Aukmate  Chayapiwat. All rights reserved.
//

import UIKit
struct LoggedUser{
    static var loggedUserName = ""
    static var loggedPassword = ""
}
class LoginViewController: UIViewController {
    
    lazy var accountVM : AccountViewModel = {
        return AccountViewModel()
    }()
    @IBOutlet var welcomeView: UIView!
    @IBOutlet var userName: UITextField!
    @IBOutlet var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        welcomeView.addGestureRecognizer(tabGesture)
    }
    
    @objc func viewTapped(){
        userName.endEditing(true)
        password.endEditing(true)
    }
    @IBAction func LoginPressed(_ sender: Any) {
        accountVM.fetchAccount()
        if(userName.text == "T" && password.text == "T"){
            performSegue(withIdentifier: "gotoFeed", sender: self)
            LoggedUser.loggedUserName = userName.text!
            LoggedUser.loggedPassword = userName.text!
        }
    }
    
    
    
}

