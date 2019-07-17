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
    case notVerified
}

enum typeOfCall : String{
    
    case getAccountBalance = "&module=account&action=get_account_balance"
    case getResourceInfo = "&module=account&action=get_account_resource_info"
    case getAccountInfo = "&module=account&action=get_account_info"
}


enum httpMethod:String {
    case post = "POST"
    case get = "GET"
}
