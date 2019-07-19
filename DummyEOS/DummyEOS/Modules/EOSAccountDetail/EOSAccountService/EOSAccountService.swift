//
//  EOSAccountService.swift
//  DummyEOS
//
//  Created by Hamza Khan on 17/07/2019.
//  Copyright © 2019 Hamza Khan. All rights reserved.
//

import Foundation
typealias EOSBalanceCompletion = (Bool, EOSBalance?, String) -> Void
typealias EOSResourceCompletion = (Bool, EOSResourceDataModel?, String) -> Void
typealias EOSConversion = (Bool, Double, String) -> Void

class EOSAccountSerivce{
    
    static func getUserResourceInfo(name: String, completion : @escaping EOSResourceCompletion){
        EOSApi.getUserResourceInfo(accountName: name) { (responseState, json, data) in
            guard let jsonData = data else { return }
            if responseState == .success {
                do{
                     let resource = try JSONDecoder().decode(EOSResourceUsageModel.self, from: jsonData)
                    guard let resourceData = resource.data else {
                        completion(false,nil,Constants.wentWrongError)
                        return
                    }
                    
                    completion(true,resourceData,"")
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
        EOSApi.getAccountBalanceInfo(accountName: name) { (responseState, json, data) in
            guard let jsonData = data else { return }
            if responseState == .success{
                //decode model here
                do{
                    let balance = try JSONDecoder().decode(EOSBalanceModel.self, from: jsonData)
                    guard let balanceDataModel = balance.data else {
                        completion(false,nil,Constants.wentWrongError)
                        return
                    }
                    completion(true,balanceDataModel,"")
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
    
    static func getConversionForEOSToUSD(completion: @escaping EOSConversion){
        EOSApi.getConvserionForEOS { (responseState, json, data) in
            if  responseState == .success{
                let rate = json["rate"].doubleValue
                completion(true, rate, "")
            }
            else{
                completion(false, 0.0, Constants.wentWrongError)
            }
        }
    }
}
