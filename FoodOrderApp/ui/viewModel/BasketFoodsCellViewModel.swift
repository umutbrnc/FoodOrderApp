//
//  BasketFoodsCellViewModel.swift
//  FoodOrderApp
//
//  Created by chvck on 31.05.2024.
//

import Foundation
import RxSwift
import RxRelay
import UIKit

class BasketFoodsCellViewModel{
    
    let username = BehaviorRelay<String?>(value: nil)
    var repo = Repository()
    var basketFoodList = BehaviorSubject<[BasketFoods]>(value: [BasketFoods]())
    
    init(){
        basketFoodList = repo.basketFoodList
    }

    func deleteBasketFood(sepet_yemek_id:Int,kullanici_adi:String){
        repo.deleteBasketFood(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
    }
    
    func addToBasket(yemek_adi:String,yemek_resim_adi:String,yemek_fiyat:Int,yemek_siparis_adet:Int,kullanici_adi:String){
        repo.addToBasket(yemek_adi: yemek_adi, yemek_resim_adi: yemek_resim_adi, yemek_fiyat: yemek_fiyat, yemek_siparis_adet: yemek_siparis_adet, kullanici_adi: kullanici_adi)
    }
    
}
