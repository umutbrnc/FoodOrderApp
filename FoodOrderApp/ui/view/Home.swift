//
//  Home.swift
//  FoodOrderApp
//
//  Created by chvck on 21.05.2024.
//

import UIKit
import RxSwift
import Kingfisher

class Home: UIViewController {

    
  //  let keyboardGesture = UISwipeGestureRecognizer(target: Home.self, action: #selector(hideKeyboard))

    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableViewFoods: UITableView!
    
    var foodList = [Foods]()
    var viewModel = HomeViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        tableViewFoods.delegate = self
        tableViewFoods.dataSource = self

        tableViewFoods.rowHeight = 100
        
        viewModel.foodList.subscribe(onNext: { list in
            self.foodList = list
            print("Received food list: \(list)")
            DispatchQueue.main.async {
                self.tableViewFoods.reloadData()
            }
        }, onError: { error in
            print("Error receiving food list: \(error)")
        }).disposed(by: disposeBag)

     //   keyboardGesture.isEnabled = false
       // view.addGestureRecognizer(keyboardGesture)
   
    }
   

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchFoods()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            if let food = sender as? Foods {
                let selectedVC = segue.destination as! Details
                selectedVC.food = food
            }
        }
    }



}


extension Home : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            viewModel.fetchFoods()
        } else {
            viewModel.search(searchKey:searchText)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
       }
    
}


extension Home : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodsCell") as! FoodsCell
        let food = foodList[indexPath.row]

        cell.lblNameCell.text = food.yemek_adi
             if let price = food.yemekFiyat {
                 cell.lblPriceCell.text = "\(price) ₺"
             } else {
                 cell.lblPriceCell.text = "N/A"
             }
        cell.configure(with: food)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let food = foodList[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: food)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
}
