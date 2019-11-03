//
//  ShoppingListTableViewController.swift
//  MoesCalculator
//


import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class ShoppingListTableViewController : UITableViewController, AddShoppingListTableViewControllerDelegate {
    
    private var orderLists = [OrderList]()
    private var rootRef :DatabaseReference!
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.rootRef = Database.database().reference()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        populateOrderList()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            
            let orderList = self.orderLists[indexPath.row]
            let orderListRef = self.rootRef.child(orderList.title)
            orderListRef.removeValue()
            
        }
    }
    
    private func populateOrderList(){
        self.rootRef.observe(.value){ snapshot in
            
            self.orderLists.removeAll()
            
            let orderListDictionary = snapshot.value as? [String:Any] ?? [:]

            for (key, _) in orderListDictionary{
                
                if let orderListDictionary = orderListDictionary[key] as? [String:Any]{
                    if let orderList = OrderList(orderListDictionary){
                        self.orderLists.append(orderList)
                    }
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func addShoppingListTableViewControllerDidCancel(controller: UIViewController) {
        
        controller.dismiss(animated: true, completion: nil)
        
    }
    
    func addShoppingListTableViewControllerDidSave(controller: UIViewController, title: String) {
        
        let orderList = OrderList(title: title)
        self.orderLists.append(orderList)
        
        let orderListRef = self.rootRef.child(orderList.title)
        orderListRef.setValue(orderList.toDictionary())
        
        controller.dismiss(animated: true, completion: nil)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderLists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderListTableViewCell", for: indexPath)
        let orderList = self.orderLists[indexPath.row]
        cell.textLabel?.text = orderList.title
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddShoppingListTableViewController" {
            
            let nc = segue.destination as! UINavigationController
            let addShoppingListVC = nc.viewControllers.first as! AddShoppingListTableViewController
            addShoppingListVC.delegate = self
            
        } else if segue.identifier == "GroceryItemsTableViewController"{
            guard let indexPath = self.tableView.indexPathForSelectedRow else{
                return
            }
            
            let barItemsTVC = segue.destination as! GroceryItemsTableViewController
            barItemsTVC.orderList = self.orderLists[indexPath.row]
            
        }
        
    }
   
   
}
