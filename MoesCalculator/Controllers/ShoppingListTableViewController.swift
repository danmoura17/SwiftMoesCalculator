//
//  ShoppingListTableViewController.swift
//  MoesCalculator
//


import Foundation
import UIKit
import Firebase

class ShoppingListTableViewController : UITableViewController, AddShoppingListTableViewControllerDelegate {
    
    private var orderLists = [OrderList]()
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func addShoppingListTableViewControllerDidCancel(controller: UIViewController) {
        
        controller.dismiss(animated: true, completion: nil)
        
    }
    
    func addShoppingListTableViewControllerDidSave(controller: UIViewController, title: String) {
        
        let orderList = OrderList(title: title)
        self.orderLists.append(orderList)
        
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
            
        }
        
    }
   
   
}
