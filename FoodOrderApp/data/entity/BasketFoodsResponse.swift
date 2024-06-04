//
//  BasketFoodsResponse.swift
//  FoodOrderApp
//
//  Created by chvck on 21.05.2024.
//

import Foundation

class BasketFoodsResponse : Codable{
    
    var basketFoods: [BasketFoods]?
    var success: Int?
    
    private enum CodingKeys: String, CodingKey {
        case basketFoods = "sepet_yemekler"
        case success
    }
    
}
