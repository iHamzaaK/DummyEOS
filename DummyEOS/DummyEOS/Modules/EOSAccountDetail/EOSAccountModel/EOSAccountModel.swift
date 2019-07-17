//
//  EOSAccountModel.swift
//  DummyEOS
//
//  Created by Hamza Khan on 17/07/2019.
//  Copyright © 2019 Hamza Khan. All rights reserved.
//

import Foundation

class EOSAccountModel{
    
    var strAccountName: String
    var strAccountKey: String
    
    
    init(accountName : String , accountKey : String) {
        self.strAccountKey = accountKey
        self.strAccountName = accountName
    }
}
