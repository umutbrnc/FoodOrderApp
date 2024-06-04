//
//  Account.swift
//  FoodOrderApp
//
//  Created by chvck on 21.05.2024.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class Account: UIViewController {
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    var viewModel = AccountViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
  
        let keyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(keyboardGesture)
        
        txtUsername.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.tintColor])
        txtEmail.attributedPlaceholder = NSAttributedString(string: "E-mail", attributes: [NSAttributedString.Key.foregroundColor: UIColor.tintColor])
 
        guard let currentUser = Auth.auth().currentUser else {
            self.viewModel.makeAlert(titleInput: "Error!", messageInput: "Current user not found", view: self)
                 return
             }
             
             let userId = currentUser.uid
             let firestore = Firestore.firestore()

             firestore.collection("userInfo").document(userId).getDocument { document, error in
                 if let error = error {
                     self.viewModel.makeAlert(titleInput: "Error!", messageInput: error.localizedDescription, view: self)
                     return
                 }
                 
                 guard let document = document, document.exists, let data = document.data() else {
                     self.viewModel.makeAlert(titleInput: "Error!", messageInput: "User data not found", view: self)
                     return
                 }
            
            self.txtEmail.text = data["email"] as? String
            self.txtUsername.text = data["username"] as? String

        }
        
    }
    
    @IBAction func btnLogoutClicked(_ sender: Any) {
        viewModel.logout()
    }

    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
}
