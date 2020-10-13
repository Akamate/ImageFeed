//
//  EditViewController.swift
//  ImageFeed
//
//  Created by Aukmate  Chayapiwat on 10/6/2562 BE.
//  Copyright © 2562 Aukmate  Chayapiwat. All rights reserved.
//

import UIKit
import DropDown

final class EditViewController: UIViewController {
    @IBOutlet private weak var numberInput: UITextField!
    @IBOutlet private weak var characterInput: UITextField!
    @IBOutlet private weak var passwordInput: UITextField!
    @IBOutlet private weak var numberOutput: UILabel!
    @IBOutlet private weak var characterOutput: UILabel!
    @IBOutlet private weak var passwordOutput: UILabel!
    @IBOutlet private weak var myView: UIView!
    @IBOutlet private weak var dropDownButton: UIButton!
    
    private lazy var dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberInput.keyboardType = .asciiCapableNumberPad
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        myView.addGestureRecognizer(tabGesture)
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
        setDropDown()
        setDelegate()
    }
    
    private func setDropDown() {
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
    
    private func setDelegate() {
        numberInput.delegate = self
        passwordInput.delegate = self
        characterInput.delegate = self
    }
    
    @objc private func viewTapped() {
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
    
    @IBAction private func dropDownPressed(_ sender: Any) {
        dropDown.show()
        viewTapped()
    }
    
    @IBAction private func numberEditing(_ sender: Any) {
            numberInput.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            numberInput.layer.borderWidth = 1.0
            numberOutput.text = numberInput.text
    }
   
    @IBAction private func characterEditing(_ sender: Any) {
            characterInput.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            characterInput.layer.borderWidth = 1.0
            characterOutput.text = characterInput.text
    }
    
    @IBAction private func passwordEditing(_ sender: Any) {
            passwordInput.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            passwordInput.layer.borderWidth = 1.0
            passwordOutput.text = passwordInput.text
    }
}

extension EditViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard !string.isEmpty, let textFieldLength = textField.text?.count else { return true }
        
        switch textField.tag {
        case 0, 2:
            return textFieldLength < 20
        case 1:
            return textFieldLength < 255
        default:
            return true
        }
    }
}
