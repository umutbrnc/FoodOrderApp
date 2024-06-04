//
//  BasketFoodsCell.swift
//  FoodOrderApp
//
//  Created by chvck on 31.05.2024.
//

import UIKit
import RxSwift
import RxCocoa

class BasketFoodsCell: UITableViewCell {

    @IBOutlet weak var imgCell: UIImageView!
    @IBOutlet weak var lblNameCell: UILabel!
    @IBOutlet weak var lblPriceCell: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblCountedPrice: UILabel!
    
    var viewModel = BasketFoodsCellViewModel()
    private var basketFood: BasketFoods? 
    private var disposeBag = DisposeBag()

    
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

        func configure(with basketFood: BasketFoods){
        self.basketFood = basketFood
        
        lblNameCell.text = basketFood.yemek_adi
        if let price = basketFood.yemek_fiyat {
            lblPriceCell.text = "\(price) ₺"
        } else {
            lblPriceCell.text = "N/A"
        }
        if let count = basketFood.yemek_siparis_adet {
            lblCount.text = "\(count)"
        } else {
            lblCount.text = "N/A"
        }
        if let count = basketFood.yemek_siparis_adet, let price = basketFood.yemek_fiyat {
            let totalPrice = Int(count)! * Int(price)!
            lblCountedPrice.text = "  ₺ \(totalPrice)"
        } else {
            lblCountedPrice.text = "N/A"
        }
        if let url = basketFood.imageURL {
            imgCell.kf.setImage(with: url)
        } else {
            imgCell.image = nil
        }

        
    }
    
    
    @IBAction func btnCountDownClicked(_ sender: Any) {
        
        guard let basketFood = self.basketFood else {
               return
           }
           guard var count = Int(lblCount.text ?? "0") else {
               return
           }
           count = max(count - 1, 0) // Minimum 0 olmalı
           lblCount.text = "\(count)"
        updateBasket(with: count)
      
       }
    
    @IBAction func btnCountUpClicked(_ sender: Any) {
        
        guard let basketFood = self.basketFood else {
            return
        }
        guard var count = Int(lblCount.text ?? "0") else {
            return
        }
        count += 1
        lblCount.text = "\(count)"
        updateBasket(with: count)

       }
    
    
    func updateBasket(with count: Int) {
        
         guard let basketFood = self.basketFood else {
             return
         }
         
         viewModel.deleteBasketFood(sepet_yemek_id: Int(basketFood.sepet_yemek_id!)!, kullanici_adi: basketFood.kullanici_adi!)
         basketFood.yemek_siparis_adet = "\(count)"
         viewModel.addToBasket(yemek_adi: basketFood.yemek_adi!, yemek_resim_adi: basketFood.yemek_resim_adi!, yemek_fiyat: Int(basketFood.yemek_fiyat!)!, yemek_siparis_adet: count, kullanici_adi: basketFood.kullanici_adi!)
         
         // Update the price label
         if let price = basketFood.yemek_fiyat {
             let totalPrice = count * Int(price)!
             lblCountedPrice.text = "  ₺ \(totalPrice)"
         }
     }
    
}
