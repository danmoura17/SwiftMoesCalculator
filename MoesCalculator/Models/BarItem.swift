//
//  BarItem.swift
//  MoesCalculator
//
//  Created by Bruno Rodrigues on 02/11/19.
//  Copyright © 2019 Daniel Moura. All rights reserved.
//

import Foundation

class BarItem{
    
    var title: String
    
    init(title :String){
        self.title = title
    }
    
    func toDictionary() -> [String:Any]{
        return ["costumerName":self.title]
    }
    
}
