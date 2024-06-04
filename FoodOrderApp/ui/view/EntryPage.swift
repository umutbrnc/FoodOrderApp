//
//  ViewController.swift
//  FoodOrderApp
//
//  Created by chvck on 21.05.2024.
//

import UIKit

class EntryPage: UIViewController {

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignup: UIButton!
    
    var viewModel = EntryPageViewModel()
    var signedUpSuccess = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnLogin.layer.cornerRadius = 15.0
        btnSignup.layer.cornerRadius = 15.0
    }

    override func viewWillAppear(_ animated: Bool) {
        if signedUpSuccess == true{
            viewModel.makeAlert(titleInput: "Success", messageInput: "Signed up successfully!",view:self)
            signedUpSuccess = false
        }
    }
    
}

