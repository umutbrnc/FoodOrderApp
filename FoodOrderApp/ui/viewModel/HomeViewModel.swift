//
//  HomeViewModel.swift
//  FoodOrderApp
//
//  Created by chvck on 21.05.2024.
//

import Foundation
import RxSwift

class HomeViewModel{
    
    var repo = Repository()
    var foodList = BehaviorSubject<[Foods]>(value: [Foods]())
    
    init(){
        foodList = repo.foodList
    }
    
    func fetchFoods(){
        repo.fetchFoods()
    }
    
    func search(searchKey:String){
        repo.search(searchKey: searchKey)
    }
    
}
