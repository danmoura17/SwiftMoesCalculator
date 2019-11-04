//
//  GroceryItemsTableViewController.swift
//  MoesCalculator
//


import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class GroceryItemsTableViewController : UITableViewController, AddGroceryItemTableViewControllerDelegate {
    
    var orderList :OrderList!
    private var rootRef :DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = orderList.title
        self.navigationItem.largeTitleDisplayMode = .never
        
        self.rootRef = Database.database().reference()
    }
    
    func addGroceryItemTableViewControllerDidCancel(controller: UIViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            self.orderList.barItems.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        
        
    }
    
    func addGroceryItemTableViewControllerDidSave(controller: UIViewController, barItem: BarItem) {
        
        var totalValue = 0.00
        let orderListRef = self.rootRef.child(self.orderList.title)
        
        self.orderList.barItems.append(barItem)
        
        switch barItem.title {
        case "Cerveja":
            totalValue += 8.32
        case "Agua":
            totalValue += 3.90
        case "Hamburguer":
            totalValue += 12.50
        default:
            totalValue += 0.01
        }
        
        self.orderList.totalValue = totalValue
        
        orderListRef.setValue(self.orderList.toDictionary())
        
        controller.dismiss(animated: true, completion: nil)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderList.barItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroceryItemTableViewCell", for: indexPath)
        let barItem  = self.orderList.barItems[indexPath.row]
        cell.textLabel?.text = barItem.title
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let nc = segue.destination as? UINavigationController else{
            return
        }
        
        guard let addBarTVC = nc.viewControllers.first as? AddGroceryItemTableViewController else{
            return
        }
        
        addBarTVC.delegate = self
    }
    
    
}
