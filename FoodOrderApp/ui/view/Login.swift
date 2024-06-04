//
//  SignIn.swift
//  FoodOrderApp
//
//  Created by chvck on 21.05.2024.
//

import UIKit

class Login: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtEmail.attributedPlaceholder = NSAttributedString(string: "E-mail", attributes: [NSAttributedString.Key.foregroundColor: UIColor.tintColor])
        txtPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.tintColor])
        
        let keyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(keyboardGesture)
        
    }

    
    @IBAction func btnLoginClicked(_ sender: Any) {
   
        if txtEmail.text == ""{
            viewModel.makeAlert(titleInput: "Fill the blanks!", messageInput: "E-mail does not exist",view:self)
        }else if txtPassword.text == ""{
            viewModel.makeAlert(titleInput: "Fill the blanks!", messageInput: "Password does not exist",view:self)
        }else{
            viewModel.login(_email: txtEmail.text!, _password: txtPassword.text!, _view: self)
        }
        
    }
    
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
   
}
