//
//  OrderList.swift
//  MoesCalculator
//
//  Created by Bruno Rodrigues on 02/11/19.
//  Copyright © 2019 Daniel Moura. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String:Any]

class OrderList{
    
    var title :String!
    var barItems :[BarItem] = [BarItem]()
    
    init(title: String){
        self.title = title
    }
    
    init?(_ dictionary :[String:Any]){
        
        guard let title = dictionary["costumerName"] as? String else{
            return nil
        }
        
        self.title = title
        let barItemsDictionary = dictionary["barItems"] as? [JSONDictionary]
        
        if let dictionaries = barItemsDictionary{
            self.barItems = dictionaries.compactMap(BarItem.init)
        }
    }
    
    func toDictionary() -> [String:Any]{
        return ["costumerName":self.title]
    }
    
}
