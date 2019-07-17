//
//  EOSAccountServiceLayer.swift
//  DummyEOS
//
//  Created by Hamza Khan on 17/07/2019.
//  Copyright © 2019 Hamza Khan. All rights reserved.
//

import Foundation
import SwiftyJSON
///this completion block are use as call back from api
typealias completionBlock = (_ state: responseState, _ response : JSON, _ rawData : Data?) -> Void
typealias failureCompletionBlock = (_ isSuccess: Bool, _ msg : String) -> Void


struct EOSApi {
    static func getUserAccountInfo(accountName: String,completion: @escaping completionBlock){
        Router.shared.APIRouter(typeCall: .getAccountBalance, parameters: ["accountName" : accountName], method: .get, completion: completion)
    }
    static func getUserResourceInfo(accountName: String,completion: @escaping completionBlock){
        Router.shared.APIRouter(typeCall: .getResourceInfo, parameters: ["accountName" : accountName], method: .get, completion: completion)
    }
    static func getUserInfo(accountName: String,completion: @escaping completionBlock){
        Router.shared.APIRouter(typeCall: .getAccountInfo, parameters: ["accountName" : accountName], method: .get, completion: completion)
    }
    
}

class Router {
    static let shared = Router()
    //api method to retrieve account info based on typeCall from server.
    func APIRouter(typeCall : typeOfCall , parameters: Dictionary<String,Any>?,method: httpMethod, completion: @escaping completionBlock){
        
        guard let accountName =  parameters?["accountName"] as? String else { return }
        
        let urlString = getURLPath(typeCall: typeCall.rawValue, accountName: accountName)
        guard let url = URL(string: urlString) else { return}
        let dataTask =  URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                if error?._code == NSURLErrorTimedOut {
                    completion(.networkIssue,JSON.null, nil)
                }
                else if error?._code == NSURLErrorNotConnectedToInternet || error?._code == NSURLErrorNetworkConnectionLost{
                    completion(.networkIssue,JSON.null, nil)
                }
                else {
                    completion(.unknown,JSON.null, nil)
                }
                return
            }
            guard let data = data else {
                completion(.unknown,JSON.null, nil)
                return
            }
            do {
                let jsonResult: Any = (try JSONSerialization.jsonObject(with: data, options:
                    JSONSerialization.ReadingOptions.mutableContainers))
                let json = JSON(jsonResult)
                print(json)
                let httpResponse = response as? HTTPURLResponse
                if(httpResponse?.statusCode == 200){
                    completion(.success,json, data)
                }else if(httpResponse?.statusCode == 401){
                    if json["errmsg"].exists(){
                        completion(.failure, json, nil)
                    }else{
                        completion(.authError,json, nil)
                    }
                }else{
                    completion(.failure,json, nil)
                }
            } catch _ {
                completion(.unknown,JSON.null, nil)
            }
            
        }
        dataTask.resume()
    }
    
    func getURLPath(typeCall : String, accountName : String)-> String{
        let strURL = Constants.baseURL + "apikey=" + Constants.apiKey + typeCall + "&account=" + accountName
        print(strURL)
        return strURL
        //        "https://api.eospark.com/api?module=account&action=get_account_resource_info&apikey=a9564ebc3289b7a14551baf8ad5ec60a&account=helloworldjs"
    }
    
    func parseFailure(status: responseState, json: JSON, completion:failureCompletionBlock){
        //failure states of api
        switch status {
        case .failure:
            if json["errmsg"].exists(){
                let message =  json["errmsg"].stringValue
                completion(false, message)
            }
            else{
                completion(false, Constants.wentWrongError)
            }
            break
            
        case .networkIssue:
            completion(false, Constants.internetError)
            
            break
        case .timeOut:
            completion(false, Constants.requestTimedOutError)
            
            break
        case .unknown:
            completion(false, Constants.wentWrongError)
            break
        default:
            completion(false, Constants.wentWrongError)
            break
        }
        
    }
}
