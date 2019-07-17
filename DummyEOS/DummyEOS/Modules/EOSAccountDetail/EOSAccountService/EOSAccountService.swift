//
//  EOSAccountService.swift
//  DummyEOS
//
//  Created by Hamza Khan on 17/07/2019.
//  Copyright © 2019 Hamza Khan. All rights reserved.
//

import Foundation
typealias EOSBalanceCompletion = (Bool, EOSBalanceModel?, String) -> Void
typealias EOSResourceCompletion = (Bool, EOSResourceUsageModel?, String) -> Void

class EOSAccountSerivce{
    
    static func getUserResourceInfo(name: String, completion : @escaping EOSResourceCompletion){
        EOSApi.getUserResourceInfo(accountName: name) { (responseState, json, data) in
            guard let jsonData = data else { return }
            
            if responseState == .success {
                do{
                    let resource = try JSONDecoder().decode(EOSResourceUsageModel.self, from: jsonData)
                    print(resource.data?.cpu?.max)
                    completion(true,resource,"")
                }
                catch{
                    print(Constants.wentWrongError)
                    completion(false,nil,Constants.wentWrongError)
                }
            }
            else{
                Router.shared.parseFailure(status: responseState, json: json, completion: { (isSuccess, msg) in
                    completion(isSuccess,nil,msg)
                })
            }
        }
    }
    
    static func getUserAccountBalance(name : String, completion : @escaping EOSBalanceCompletion){
        EOSApi.getUserAccountInfo(accountName: name) { (responseState, json, data) in
            guard let jsonData = data else { return }
            
            if responseState == .success{
                //decode model here
                do{
                    let balance = try JSONDecoder().decode(EOSBalanceModel.self, from: jsonData)
                    print(balance.data?.balance)
                    
                    completion(true,balance,"")
                }
                catch{
                    print(Constants.wentWrongError)
                    completion(false,nil,Constants.wentWrongError)
                }
            }
            else{
                Router.shared.parseFailure(status: responseState, json: json, completion: { (isSuccess, msg) in
                    completion(isSuccess,nil,msg)
                })
            }
        }
    }
    
//    static func getAccountInfo(name: String , completion : @escaping EOSAccountCompletion){
//        EOSApi.getUserAccountInfo(accountName: name){ (responseState, json, data) in
//            guard let jsonData = data else { return }
//
//            if responseState == .success{
//                //decode model here
//                do{
//                    let balance = try JSONDecoder().decode(EOSBalanceModel.self, from: jsonData)
//                    print(balance.data?.balance)
//                    completion(true,nil,"")
//                }
//                catch{
//                    print(Constants.wentWrongError)
//                }
//
//            }
//            else{
//                Router.shared.parseFailure(status: responseState, json: json, completion: { (isSuccess, msg) in
//                    completion(isSuccess,nil,msg)
//                })
//            }
//        }
//
//    }
    
}
