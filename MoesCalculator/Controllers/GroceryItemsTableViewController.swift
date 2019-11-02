//
//  GroceryItemsTableViewController.swift
//  MoesCalculator
//


import Foundation
import UIKit
import Firebase

class GroceryItemsTableViewController : UITableViewController, AddGroceryItemTableViewControllerDelegate {
    func addGroceryItemTableViewControllerDidCancel(controller: UIViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func addGroceryItemTableViewControllerDidSave(controller: UIViewController, barItem: BarItem) {
        self.orderList.barItems.append(barItem)
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
    
    
    var orderList :OrderList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = orderList.title
        self.navigationItem.largeTitleDisplayMode = .never
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
