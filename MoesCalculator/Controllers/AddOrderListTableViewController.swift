//
//  AddOrderListTableViewController.swift
//  MoesCalculator
//


import Foundation
import UIKit

protocol AddOrderListTableViewControllerDelegate{
    
    func AddOrderListTableViewControllerDidSave(controller :UIViewController, title :String)
    func AddOrderListTableViewControllerDidCancel(controller :UIViewController)
    
}

class AddOrderListTableViewController : UITableViewController {
    
    @IBOutlet weak var titleTextField :UITextField!
    var delegate :AddOrderListTableViewControllerDelegate!
    
    @IBAction func save() {
        
        if let title = self.titleTextField.text{
            self.delegate.AddOrderListTableViewControllerDidSave(controller: self, title: title)
        }
        
    }
    
    @IBAction func cancel() {
        self.delegate.AddOrderListTableViewControllerDidCancel(controller: self)
        
    }
    
    
   
}
