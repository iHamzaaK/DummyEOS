//
//  EOSAccountServiceLayer.swift
//  DummyEOS
//
//  Created by Hamza Khan on 17/07/2019.
//  Copyright © 2019 Hamza Khan. All rights reserved.
//

import Foundation

///this completion block are use as call back from api
typealias completionBlock = (_ state: responseState, _ response : Dictionary<String,Any>) -> Void


struct EOSApi {
    static func getUserAccountInfo(completion: @escaping completionBlock){
        Router.APIRouter(typeCall: .getAccountBalance, parameters: nil, method: .get, completion: completion)
    }
    
}

struct Router {
    static func APIRouter(typeCall : typeOfCall , parameters: Dictionary<String,Any>?,method: httpMethod, completion: @escaping completionBlock){
        
    }
}
