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
    
    @IBOutlet private weak var myView: UIView!
    @IBOutlet private weak var oldPassword: UITextField!
    @IBOutlet private weak var userName: UILabel!
    @IBOutlet private weak var newPassword: UITextField!
    @IBOutlet private weak var confirmPassword: UITextField!
    
    private var textFieldColor: CGColor?
    
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
    
    @objc private func viewTapped() {
        oldPassword.endEditing(true)
        newPassword.endEditing(true)
        confirmPassword.endEditing(true)
    }
    
    @IBAction private func confirmPressed(_ sender: Any) {
        guard let oldPasswordText = oldPassword.text, let newPassword = newPassword.text, let confirmPassword = confirmPassword.text, let userName = userName.text else { return }
        if oldPasswordText == accountVM.getPassword(userName: userName) && newPassword == confirmPassword {
            accountVM.saveAccount(userName: userName, password: newPassword)
            showAlert(title : "Change Password Successfully")
            tabBarController?.selectedIndex = 0
        } else {
            showAlert(title: "Wrong Password")
            oldPassword.layer.borderColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
            oldPassword.layer.borderWidth = 1.0
            shakeTextField()
        }
    }
    
    private func showAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    private func shakeTextField() {
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
