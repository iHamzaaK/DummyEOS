//
//  Enums.swift
//  DummyEOS
//
//  Created by Hamza Khan on 17/07/2019.
//  Copyright © 2019 Hamza Khan. All rights reserved.
//

import Foundation


enum responseState {
    case success
    case failure
    case authError
    case unknown
    case networkIssue
    case timeOut
    case notVarified
}

enum typeOfCall : String{
    
    case getAccountBalance = "get_account_balance"
    
}


enum httpMethod:String {
    case post = "POST"
    case get = "GET"
}
