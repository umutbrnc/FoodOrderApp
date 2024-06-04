//
//  FoodsCell.swift
//  FoodOrderApp
//
//  Created by chvck on 28.05.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class FoodsCell: UITableViewCell {
    
    var viewModel = FoodsCellViewModel()
    private var food: Foods?
    
    @IBOutlet weak var imgCell: UIImageView!
    @IBOutlet weak var lblNameCell: UILabel!
    @IBOutlet weak var lblPriceCell: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 2.0
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with food: Foods) {
        self.food = food
        lblNameCell.text = food.yemek_adi
        if let price = food.yemekFiyat {
            lblPriceCell.text = "\(price) ₺"
        } else {
            lblPriceCell.text = "N/A"
        }
        
        if let url = food.imageURL {
            imgCell.kf.setImage(with: url)
        } else {
            imgCell.image = nil
        }
    }
    
    
    @IBAction func btnAddToBasketClicked(_ sender: Any) {
        
           guard let currentUser = Auth.auth().currentUser else {
               print("Error: User not authenticated!")
               return
           }
           
           guard let food = self.food else {
               print("Error: Food data not available!")
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

               self.viewModel.addToBasket(yemek_adi: food.yemek_adi!, yemek_resim_adi: food.yemek_resim_adi!, yemek_fiyat: food.yemekFiyat!, yemek_siparis_adet: Int(1), kullanici_adi: currentUsername)
           }
       }
    
    
    
    
}
