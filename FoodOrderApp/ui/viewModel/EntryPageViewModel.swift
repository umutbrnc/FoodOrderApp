//
//  EntryPageViewModel.swift
//  FoodOrderApp
//
//  Created by chvck on 21.05.2024.
//

import Foundation
import UIKit

class EntryPageViewModel{
    
    var repo = Repository()
    
    func makeAlert( titleInput : String , messageInput : String, view : UIViewController) {
        repo.makeAlert(titleInput: titleInput, messageInput: messageInput, view: view)
    }
    
}
