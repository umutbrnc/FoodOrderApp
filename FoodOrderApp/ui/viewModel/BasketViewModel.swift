//
//  BasketViewModel.swift
//  FoodOrderApp
//
//  Created by chvck on 21.05.2024.
//

import Foundation
import RxSwift
import UIKit

class BasketViewModel{
 
    var repo = Repository()
    var basketFoodList = BehaviorSubject<[BasketFoods]>(value: [BasketFoods]())
    
    init(){
        basketFoodList = repo.basketFoodList
    }
    
    func makeAlert( titleInput : String , messageInput : String, view : UIViewController) {
        repo.makeAlert(titleInput: titleInput, messageInput: messageInput, view: view)
    }
    
    func fetchBasketFoods(kullanici_adi:String){
        repo.fetchBasketFoods(kullanici_adi: kullanici_adi)
    }
    
    func deleteBasketFood(sepet_yemek_id:Int,kullanici_adi:String){
        repo.deleteBasketFood(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
    }
    
}
