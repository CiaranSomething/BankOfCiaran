//
//  CustomerDataModel.swift
//  RESTfulApp
//
//  Created by Ciaran Corrigan on 06/01/2020.
//  Copyright © 2020 Ciaran Corrigan. All rights reserved.
//

import UIKit

class Customer {
    var name : String = ""
    var id : String = ""
    var addressFirstLine : String = ""
 //   var myAccount : AccountDataModel?
    
    init(name : String, id : String, addressFirstLine : String) {
        self.name = name
        self.id = id
        self.addressFirstLine = addressFirstLine
        //self.myAccount = nil
    }
}

