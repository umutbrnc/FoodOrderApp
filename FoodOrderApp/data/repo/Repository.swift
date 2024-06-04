//
//  Repository.swift
//  FoodOrderApp
//
//  Created by chvck on 21.05.2024.
//

import Foundation
import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import Alamofire
import RxSwift

class Repository{
    
    var foodList = BehaviorSubject<[Foods]>(value: [Foods]())
    var basketFoodList = BehaviorSubject<[BasketFoods]>(value: [BasketFoods]())
    
    
    func fetchFoods() {
        
        let url = URL(string: "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php")!
        AF.request(url, method: .get).response { response in
            if let error = response.error {
                print("Error making request: \(error)")
                return
            }
            
            guard let data = response.data else {
                print("No data received")
                return
            }
            
            do {
                let response = try JSONDecoder().decode(FoodsResponse.self, from: data)
                if let list = response.foods {
                    self.foodList.onNext(list)
                } else {
                    print("No foods found in response")
                }
            } catch {
                print("Error decoding response: \(error)")
            }
        }
    }
    
    
    
    
    func search(searchKey: String) {
        
        guard let currentFoodList = try? foodList.value() else {
            print("Error: Food list is empty")
            return
        }
        
        let filteredList = currentFoodList.filter { $0.yemek_adi?.lowercased().contains(searchKey.lowercased()) ?? false }
        foodList.onNext(filteredList)
    }
    
    
    
    
    func addToBasket(yemek_adi:String,yemek_resim_adi:String,yemek_fiyat:Int,yemek_siparis_adet:Int,kullanici_adi:String){
        
        let url = URL(string:"http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php")!
        let params:Parameters = ["yemek_adi":yemek_adi,"yemek_resim_adi":yemek_resim_adi,"yemek_fiyat":yemek_fiyat,"yemek_siparis_adet":yemek_siparis_adet,"kullanici_adi":kullanici_adi]
        
        AF.request(url,method: .post,parameters: params).response{ response in
            if let data = response.data{
                do {
                    let response = try JSONDecoder().decode(CRUDResponse.self, from: data)
                    print("Success: \(response.success!)")
                    print("Message: \(response.message!)")
                } catch {
                    print("JSON decode error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    
    
    
    func fetchBasketFoods(kullanici_adi: String) {
        
        let url = URL(string: "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php")!
        let params: Parameters = ["kullanici_adi": kullanici_adi]
        AF.request(url,method: .post,parameters: params).response{ response in
            if let data = response.data{
                print("Data: \(String(data: data, encoding: .utf8) ?? "Nil data!")")
                do {
                    let response = try JSONDecoder().decode(BasketFoodsResponse.self, from: data)
                    if let list = response.basketFoods {
                        self.basketFoodList.onNext(list)
                    }
                } catch {
                    print("JSON decode error 2 : \(error.localizedDescription)")
                }
            }
        }
    }
    
    
    
    
    func deleteBasketFood(sepet_yemek_id:Int,kullanici_adi:String){
        
        let url = URL(string:"http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php")!
        let params:Parameters = ["sepet_yemek_id":sepet_yemek_id,"kullanici_adi":kullanici_adi]
        
        AF.request(url,method: .post,parameters: params).response{ response in
            if let data = response.data{
                do{
                    let response = try JSONDecoder().decode(CRUDResponse.self,from: data)
                    print("Success : \(response.success!)")
                    print("Message : \(response.message!)")
                    
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    
    func makeAlert( titleInput : String , messageInput : String, view : UIViewController) {
        let Alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle:.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        Alert.addAction (okButton)
        view.present(Alert,animated: true)
    }
    
    
    
    
    // FIREBASE FUNCTIONS
    
    func fetchCurrentUsername(completion: @escaping (Result<String, Error>) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not found!"])))
            return
        }
        
        let userId = currentUser.uid
        let firestore = Firestore.firestore()
        
        
        firestore.collection("userInfo").document(userId).getDocument { document, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let document = document, document.exists, let data = document.data(), let fetchedUsername = data["username"] as? String else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User data not found!"])))
                return
            }
            
            completion(.success(fetchedUsername))
        }
    }
    
    
    func login(_email:String,_password:String,_view:UIViewController){
        
        Auth.auth().signIn(withEmail: _email, password: _password) { result, error in
            if error != nil{
                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Unknown error", view: _view)
            }else{
                _view.performSegue(withIdentifier: "toMainVC", sender: nil)
            }
        }//...closure
        
    }
    
    
    
    func signUp(email: String, password: String, username: String, view: UIViewController) {

        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.makeAlert(titleInput: "Error!", messageInput: error.localizedDescription, view: view)
            } else {
                guard let user = authResult?.user else {
                    self.makeAlert(titleInput: "Error!", messageInput: "User doesn't create", view: view)
                    return
                }

                let firestore = Firestore.firestore()
                let userDictionary: [String: Any] = ["email": email, "username": username]

                firestore.collection("userInfo").document(user.uid).setData(userDictionary) { error in
                    if let error = error {
                        self.makeAlert(titleInput: "Error!", messageInput: error.localizedDescription, view: view)
                    } else {
                        view.performSegue(withIdentifier: "toSignedUp", sender: nil)
                    }
                }
            }
        }
    }
    
    
    
    func logout(){
        
        do {
            try Auth.auth().signOut()
            print("Logout successful")
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    
    
    
    
}
