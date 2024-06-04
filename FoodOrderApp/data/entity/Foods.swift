//
//  Foods.swift
//  FoodOrderApp
//
//  Created by chvck on 21.05.2024.
//

import Foundation

class Foods : Codable{
    
    var yemek_id: String?
    var yemek_adi: String?
    var yemek_resim_adi: String?
    var yemek_fiyat: String?
    
    //computed property
    
    var yemekID: Int? {
        return Int(yemek_id ?? "")
    }
    
    var yemekFiyat: Int? {
        return Int(yemek_fiyat ?? "")
    }
    
    var imageURL: URL? {
        guard let imageName = yemek_resim_adi else { return nil }
        return URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(imageName)")
    }
    
    init(yemek_id: String?, yemek_adi: String?, yemek_resim_adi: String?, yemek_fiyat: String?) {
        self.yemek_id = yemek_id
        self.yemek_adi = yemek_adi
        self.yemek_resim_adi = yemek_resim_adi
        self.yemek_fiyat = yemek_fiyat
    }
    
}
