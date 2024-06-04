//
//  BasketFoods.swift
//  FoodOrderApp
//
//  Created by chvck on 21.05.2024.
//

import Foundation
import RxSwift
import RxCocoa

class BasketFoods : Codable{
    
    var sepet_yemek_id: String?
    var yemek_adi: String?
    var yemek_resim_adi: String?
    var yemek_fiyat: String?
    var yemek_siparis_adet: String?
    var kullanici_adi: String?

    
    var imageURL: URL? {
        guard let imageName = yemek_resim_adi else { return nil }
        return URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(imageName)")
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case sepet_yemek_id = "sepet_yemek_id"
        case yemek_adi
        case yemek_resim_adi
        case yemek_fiyat
        case yemek_siparis_adet
        case kullanici_adi
    }
    
    
    init(sepet_yemek_id: String?, yemek_adi: String?, yemek_resim_adi: String?, yemek_fiyat: String?,yemek_siparis_adet:String?,kullanici_adi:String?) {
        self.sepet_yemek_id = sepet_yemek_id
        self.yemek_adi = yemek_adi
        self.yemek_resim_adi = yemek_resim_adi
        self.yemek_fiyat = yemek_fiyat
        self.yemek_siparis_adet = yemek_siparis_adet
        self.kullanici_adi = kullanici_adi
    }
    
 
    
}
