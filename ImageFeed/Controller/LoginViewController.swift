//
//  ViewController.swift
//  ImageFeed
//
//  Created by Aukmate  Chayapiwat on 4/6/2562 BE.
//  Copyright © 2562 Aukmate  Chayapiwat. All rights reserved.
//

import UIKit
import LocalAuthentication

struct LoggedUser{
    static var loggedUserName = ""
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
        accountVM.saveAccount(userName: "T", password: "T")
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        welcomeView.addGestureRecognizer(tabGesture)
        print("password \(accountVM.getPassword(userName: "T"))")
    }
    
    @objc func viewTapped(){
        userName.endEditing(true)
        password.endEditing(true)
    }
    @IBAction func LoginPressed(_ sender: Any) {
        if(accountVM.checkLoginComplete(userName: userName.text!, password: password.text!)){
            performSegue(withIdentifier: "gotoFeed", sender: self)
            LoggedUser.loggedUserName = userName.text!
            userName.text = ""
            password.text = ""
        }
        else {
            authenticateUser()
        }
    }
    
    func authenticateUser() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [unowned self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        self.performSegue(withIdentifier: "gotoFeed", sender: self)
                    } else {
                        let ac = UIAlertController(title: "Authentication failed", message: "Sorry!", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(ac, animated: true)
                    }
                }
            }
        } else {
            let ac = UIAlertController(title: "Touch ID not available", message: "Your device is not configured for Touch ID.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
}

