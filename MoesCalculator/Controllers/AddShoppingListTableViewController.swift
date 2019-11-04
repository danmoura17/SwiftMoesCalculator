//
//  AddShoppingListTableViewController.swift
//  MoesCalculator
//


import Foundation
import UIKit

protocol AddShoppingListTableViewControllerDelegate{
    
    func addShoppingListTableViewControllerDidSave(controller :UIViewController, title :String)
    func addShoppingListTableViewControllerDidCancel(controller :UIViewController)
    
}

class AddShoppingListTableViewController : UITableViewController {
    
    @IBOutlet weak var titleTextField :UITextField!
    var delegate :AddShoppingListTableViewControllerDelegate!
    
    @IBAction func save() {
        
        if let title = self.titleTextField.text{
            self.delegate.addShoppingListTableViewControllerDidSave(controller: self, title: title)
        }
        
    }
    
    @IBAction func cancel() {
        self.delegate.addShoppingListTableViewControllerDidCancel(controller: self)
        
    }
    
    
   
}
