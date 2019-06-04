//
//  ViewController.swift
//  ImageFeed
//
//  Created by Aukmate  Chayapiwat on 4/6/2562 BE.
//  Copyright © 2562 Aukmate  Chayapiwat. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var userName: UITextField!
    @IBOutlet var password: UITextField!
    var user : String = "Test"
    var pass : String = "Test"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    @IBAction func LoginPressed(_ sender: Any) {
        //if(userName.text == "" && password.text == ""){
            performSegue(withIdentifier: "gotoFeed", sender: self)
        //}
    }
    
    
    
}

