//
//  SignUp.swift
//  FoodOrderApp
//
//  Created by chvck on 21.05.2024.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class SignUp: UIViewController {
    
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    var viewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtUsername.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.tintColor])
        txtEmail.attributedPlaceholder = NSAttributedString(string: "E-mail", attributes: [NSAttributedString.Key.foregroundColor: UIColor.tintColor])
        txtPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.tintColor])
        txtConfirmPassword.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.tintColor])
        
        let keyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(keyboardGesture)
        
    }
    
    
    @IBAction func btnSignUpClicked(_ sender: Any) {
        
        if txtUsername.text == ""{
            viewModel.makeAlert(titleInput: "Fill the blanks!", messageInput: "Username does not exist", view: self)
        }else if txtEmail.text == ""{
            viewModel.makeAlert(titleInput: "Fill the blanks!", messageInput: "E-mail does not exist", view: self)
        }else if txtPassword.text == ""{
            viewModel.makeAlert(titleInput: "Fill the blanks!", messageInput: "Password does not exist", view: self)
        }else if txtConfirmPassword.text == ""{
            viewModel.makeAlert(titleInput: "Fill the blanks!", messageInput: "Confirm Password does not exist", view: self)
        }else if txtPassword.text != txtConfirmPassword.text{
            viewModel.makeAlert(titleInput: "Error!", messageInput: "Passwords don't match", view: self)
        }else{
            viewModel.signUp(_email:txtEmail.text!,_password:txtPassword.text!,_username:txtUsername.text!,_view:self)
        }
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSignedUp"{
            let destinationVC = segue.destination as? EntryPage
            destinationVC?.signedUpSuccess = true
        }
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
}



