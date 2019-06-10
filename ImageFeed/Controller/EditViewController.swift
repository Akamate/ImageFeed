//
//  EditViewController.swift
//  ImageFeed
//
//  Created by Aukmate  Chayapiwat on 10/6/2562 BE.
//  Copyright © 2562 Aukmate  Chayapiwat. All rights reserved.
//

import UIKit
import DropDown
class EditViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var numberInput: UITextField!
    @IBOutlet weak var characterInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var numberOutput: UILabel!
    @IBOutlet weak var characterOutput: UILabel!
    @IBOutlet weak var passwordOutput: UILabel!
    @IBOutlet weak var myView: UIView!
 
    @IBOutlet var dropDownButton: UIButton!
    let dropDown = DropDown()
    override func viewDidLoad() {
        super.viewDidLoad()
        numberInput.keyboardType = .asciiCapableNumberPad
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        myView.addGestureRecognizer(tabGesture)
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
        setDropDown()
        setDelegate()
    }
    func setDelegate(){
        numberInput.delegate = self
        passwordInput.delegate = self
        characterInput.delegate = self
    }
    @objc func viewTapped(){
        numberInput.endEditing(true)
        characterInput.endEditing(true)
        passwordInput.endEditing(true)
        numberInput.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        numberInput.layer.borderWidth = 0.0
        characterInput.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        characterInput.layer.borderWidth = 0.0
        passwordInput.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        passwordInput.layer.borderWidth = 0.0
    }
    @IBAction func dropDownPressed(_ sender: Any) {
        dropDown.show()
        viewTapped()
    }
    @IBAction func numberEditing(_ sender: Any) {
            numberInput.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            numberInput.layer.borderWidth = 1.0
            numberOutput.text = numberInput.text
    }
   
    @IBAction func characterEditing(_ sender: Any) {
            characterInput.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            characterInput.layer.borderWidth = 1.0
            characterOutput.text = characterInput.text
    }
    @IBAction func passwordEditing(_ sender: Any) {
            passwordInput.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            passwordInput.layer.borderWidth = 1.0
            passwordOutput.text = passwordInput.text
    }
    func setDropDown(){
        dropDown.anchorView = dropDownButton
        dropDown.direction = .bottom
        for i in 1...30{
            dropDown.dataSource.append("\(i)")
        }
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.dropDownButton.setTitle(item, for: .normal)
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(string == ""){
            return true
        }
        
        if(textField.tag == 0 || textField.tag == 2){
            return (textField.text?.count)! < 20
        }
        else if(textField.tag == 1){
            return (textField.text?.count)! < 255
        }
        else{
            return true
        }
    }
}

