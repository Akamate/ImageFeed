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
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    var textFieldColor : CGColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        myView.addGestureRecognizer(tabGesture)
        textFieldColor = oldPassword.layer.borderColor
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
        self.tabBarController?.navigationItem.title = "Change Password"
        self.tabBarController?.navigationItem.leftBarButtonItem = nil
        self.userName.text = LoggedUser.loggedUserName
        print(LoggedUser.loggedUserName)
    }
    
    @objc func viewTapped(){
        oldPassword.endEditing(true)
        newPassword.endEditing(true)
        confirmPassword.endEditing(true)
    }
    @IBAction func confirmPressed(_ sender: Any) {
        if(oldPassword.text != "" && newPassword.text != "" && confirmPassword.text != ""){
            if(oldPassword.text == accountVM.getPassword(userName: userName.text!)){
                if(newPassword.text == confirmPassword.text){
                    accountVM.saveAccount(userName: userName.text!, password: newPassword.text!)
                    showAlert(message : "Change Password Successfully")
                    self.tabBarController?.selectedIndex = 0
                }
            }
            else {
                showAlert(message: "Wrong Password")
                oldPassword.layer.borderColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
                oldPassword.layer.borderWidth = 1.0
                shakeTextField()
            }
        }
    }
    func showAlert(message : String){
        let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert,animated: true)
    }
    func shakeTextField(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: oldPassword.center.x - 5, y: oldPassword.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: oldPassword.center.x + 5, y: oldPassword.center.y))
        oldPassword.layer.add(animation, forKey: "position")
    }
}

extension AccountViewController : UITextViewDelegate {
    @IBAction func oldPasswordBeginEditing(_ sender: Any) {
        oldPassword.layer.borderColor = textFieldColor
        oldPassword.layer.borderWidth = 0
    }
}
