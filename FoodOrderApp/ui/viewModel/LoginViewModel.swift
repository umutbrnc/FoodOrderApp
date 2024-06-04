//
//  LoginViewModel.swift
//  FoodOrderApp
//
//  Created by chvck on 21.05.2024.
//

import Foundation
import UIKit

class LoginViewModel{
    
    var repo = Repository()
    
    func makeAlert( titleInput : String , messageInput : String, view : UIViewController) {
        repo.makeAlert(titleInput: titleInput, messageInput: messageInput, view: view)
    }
    
    func login(_email:String,_password:String,_view:UIViewController){
        repo.login(_email: _email, _password: _password, _view: _view)
    }
    
}
