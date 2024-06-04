//
//  FoodsResponse.swift
//  FoodOrderApp
//
//  Created by chvck on 21.05.2024.
//

import Foundation

class FoodsResponse : Codable{
    
    var foods: [Foods]?
    var success: Int?
    
    private enum CodingKeys: String, CodingKey {
        case foods = "yemekler"
        case success
    }
}
