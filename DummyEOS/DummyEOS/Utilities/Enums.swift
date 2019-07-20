//
//  Enums.swift
//  DummyEOS
//
//  Created by Hamza Khan on 17/07/2019.
//  Copyright © 2019 Hamza Khan. All rights reserved.
//

import Foundation
import UIKit

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
    case getEOSConversionToUSD = "EOS/USD"
}

enum httpMethod:String {
    case post = "POST"
    case get = "GET"
}

enum EOSAccountCells : String {
    case resourceCellView = "ResourceCellView"
    case resourceHeaderView = "ResourceHeaderView"
}

enum EOSAccountRowEstimatedHeight : CGFloat{
    case accountCellHeight = 80
    case accountHeaderHeight = 70
}

enum ProjectStoryboards: String{
    case main = "Main"
}

enum ControllersList : String{
    case eosAccountDetail = "EOSAccountController"
}


