//
//  Basket.swift
//  FoodOrderApp
//
//  Created by chvck on 21.05.2024.
//

import UIKit
import RxSwift
import FirebaseAuth
import FirebaseFirestore

class Basket: UIViewController {

    @IBOutlet weak var tableViewBasketFoods: UITableView!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    
    var viewModel = BasketViewModel()
    var basketFoodList = [BasketFoods]()
    var disposeBag = DisposeBag()
    var username = ""
    var totalPrice : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewBasketFoods.delegate = self
        tableViewBasketFoods.dataSource = self
        tableViewBasketFoods.rowHeight = 100

        viewModel.basketFoodList.subscribe(onNext: { list in
            self.basketFoodList = list
            print("Received food list: \(list)")
            DispatchQueue.main.async {
                self.tableViewBasketFoods.reloadData()
                self.calculateTotalPrice()
            }
        }, onError: { error in
            print("Error receiving food list: \(error)")
        }).disposed(by: disposeBag)
 
        
           guard let currentUser = Auth.auth().currentUser else {
               print("Error: User not authenticated!")
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
               
               self.lblUsername.text = currentUsername
               self.username = currentUsername
               self.viewModel.fetchBasketFoods(kullanici_adi: self.username)
           }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        calculateTotalPrice()
        viewModel.fetchBasketFoods(kullanici_adi: self.username)
    }
 
 
    @IBAction func btnPlaceOrderClicked(_ sender: Any) {
        viewModel.makeAlert(titleInput: "Order successfully!", messageInput: "", view: self)
        basketFoodList.removeAll()
        tableViewBasketFoods.reloadData()
    }
    
    func calculateTotalPrice() {
        totalPrice = basketFoodList.reduce(0) { (result, basketFood) in
            let price = Int(basketFood.yemek_fiyat!) ?? 0
            let count = Int(basketFood.yemek_siparis_adet!) ?? 0
            return result + (price * count)
        }
        lblTotalPrice.text = "Total : \(totalPrice)₺"
    }

    
}



extension Basket : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basketFoodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "basketFoodsCell") as! BasketFoodsCell
        let basketFood = basketFoodList[indexPath.row]

        cell.lblNameCell.text = basketFood.yemek_adi
        if let price = basketFood.yemek_fiyat {
                 cell.lblPriceCell.text = "\(price) ₺"
             } else {
                 cell.lblPriceCell.text = "N/A"
             }
        cell.configure(with: basketFood)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){ contextualAction,view,bool in
            let basketFood = self.basketFoodList[indexPath.row]
            
            let alert = UIAlertController(title: "Delete!", message: "You want to delete \(basketFood.yemek_adi!)?", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancelAction)
            
            let yesAction = UIAlertAction(title: "Yes", style: .destructive){ _ in
                self.viewModel.deleteBasketFood(sepet_yemek_id: Int(basketFood.sepet_yemek_id!)!, kullanici_adi: basketFood.kullanici_adi!)
                self.basketFoodList.remove(at: indexPath.row)
                DispatchQueue.main.async {
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                    self.calculateTotalPrice()
                }
            }
            alert.addAction(yesAction)
            
            self.present(alert, animated: true)
        }
        tableViewBasketFoods.reloadData()
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
    
}
