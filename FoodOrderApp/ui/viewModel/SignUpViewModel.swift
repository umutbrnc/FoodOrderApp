//
//  SignUpViewModel.swift
//  FoodOrderApp
//
//  Created by chvck on 21.05.2024.
//

import Foundation
import UIKit

class SignUpViewModel{
    
    var repo = Repository()
    
    func makeAlert( titleInput : String , messageInput : String, view : UIViewController) {
        repo.makeAlert(titleInput: titleInput, messageInput: messageInput, view: view)
    }
    
    func signUp(_email:String,_password:String,_username:String,_view:UIViewController){
        repo.signUp(email: _email, password: _password,username:_username, view: _view)
    }
    
}
