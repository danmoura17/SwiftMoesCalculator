//
//  AddGroceryItemTableViewController.swift
//  MoesCalculator
//


import Foundation
import UIKit

protocol AddGroceryItemTableViewControllerDelegate{
    
    func addGroceryItemTableViewControllerDidCancel(controller :UIViewController)
    func addGroceryItemTableViewControllerDidSave(controller :UIViewController, barItem :BarItem)
    
}

class AddGroceryItemTableViewController : UITableViewController {
    
    @IBOutlet weak var titleTextField :UITextField!
    var delegate :AddGroceryItemTableViewControllerDelegate!
    
    @IBAction func save() {
        if let title = self.titleTextField.text{
            let barItem = BarItem(title: title)
            self.delegate.addGroceryItemTableViewControllerDidSave(controller: self, barItem: barItem)
        }
    }
    
    @IBAction func cancel() {
        self.delegate.addGroceryItemTableViewControllerDidCancel(controller: self)
    }
}
