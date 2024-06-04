//
//  AccountViewModel.swift
//  FoodOrderApp
//
//  Created by chvck on 21.05.2024.
//

import Foundation
import UIKit

class AccountViewModel{
    
    var repo = Repository()
    
    func logout(){
        repo.logout()
    }
    
    func makeAlert( titleInput : String , messageInput : String, view : UIViewController) {
        repo.makeAlert(titleInput: titleInput, messageInput: messageInput, view: view)
    }
    
}
