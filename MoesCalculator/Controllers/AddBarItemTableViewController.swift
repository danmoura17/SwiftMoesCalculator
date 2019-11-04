//
//  AddBarItemTableViewController.swift
//  MoesCalculator
//


import Foundation
import UIKit

protocol AddBarItemTableViewControllerDelegate{
    
    func AddBarItemTableViewControllerDidCancel(controller :UIViewController)
    func AddBarItemTableViewControllerDidSave(controller :UIViewController, barItem :BarItem)
    
}

class AddBarItemTableViewController : UITableViewController {
    
    @IBOutlet weak var titleTextField :UITextField!
    var delegate :AddBarItemTableViewControllerDelegate!
    
    @IBAction func save() {
        
        
        if let title = self.titleTextField.text{
            let barItem = BarItem(title: title)
            self.delegate.AddBarItemTableViewControllerDidSave(controller: self, barItem: barItem)
        }
    }
    
    @IBAction func cancel() {
        self.delegate.AddBarItemTableViewControllerDidCancel(controller: self)
    }
}
