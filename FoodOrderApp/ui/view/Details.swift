//
//  Details.swift
//  FoodOrderApp
//
//  Created by chvck on 21.05.2024.
//

import UIKit
import Kingfisher
import FirebaseFirestore
import FirebaseAuth

class Details: UIViewController {

    
    @IBOutlet weak var imgFood: UIImageView!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var lblFoodPrice: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    
    
    var viewModel = DetailsViewModel()
    var food:Foods?
    var counter : Int = 1
    var foodPrice : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let f = food {
            lblFoodName.text = f.yemek_adi
            lblFoodPrice.text = "\(String(describing: f.yemek_fiyat!))₺"
            foodPrice = Int(f.yemek_fiyat!)!
            
            if let url = f.imageURL {
                imgFood.kf.setImage(with: url)
            } else {
                imgFood.image = nil
            }
        }
        
        lblCount.text = "1"
        lblTotalPrice.text = "₺ \(foodPrice)"
     
    }//...viewDidLoad
    

    @IBAction func btnMinusClicked(_ sender: Any) {
        if counter > 1{
            counter -= 1
        }
        lblCount.text = String(counter)
        lblTotalPrice.text = "₺ \(String(foodPrice*counter))"
    }
    
    @IBAction func btnPlusClicked(_ sender: Any) {
        if counter >= 0{
            counter += 1
        }
        lblCount.text = String(counter)
        lblTotalPrice.text = "₺ \(String(foodPrice*counter))"
    }
    
    
    @IBAction func btnAddToBasketClicked(_ sender: Any) {
        
        guard let currentUser = Auth.auth().currentUser else {
                    print("Error: User not authenticated!")
                    return
                }
                
                let userId = currentUser.uid
                let firestore = Firestore.firestore()

                firestore.collection("userInfo").document(userId).getDocument { document, error in
                    if let error = error {
                        print("Error fetching document: \(error)")
                        return
                    }
                    guard let document = document, document.exists, let data = document.data() else {
                        print("Document does not exist")
                        return
                    }
                    
                    guard let currentUsername = data["username"] as? String else {
                        print("Error: Username not found!")
                        return
                    }
  
                    self.viewModel.addToBasket(yemek_adi: self.food!.yemek_adi!, yemek_resim_adi: self.food!.yemek_resim_adi!, yemek_fiyat: self.food!.yemekFiyat!, yemek_siparis_adet: self.counter, kullanici_adi: currentUsername)
                }
            dismiss(animated: true, completion: nil)
            }
        
        
    }
    
    


