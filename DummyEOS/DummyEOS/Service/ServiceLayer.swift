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
    static func getAccountBalanceInfo(accountName: String,completion: @escaping completionBlock){
        Router.shared.APIRouter(typeCall: .getAccountBalance, parameters: ["accountName" : accountName], method: .get, completion: completion)
    }
    static func getUserResourceInfo(accountName: String,completion: @escaping completionBlock){
        Router.shared.APIRouter(typeCall: .getResourceInfo, parameters: ["accountName" : accountName], method: .get, completion: completion)
    }
    static func getUserInfo(accountName: String,completion: @escaping completionBlock){
        Router.shared.APIRouter(typeCall: .getAccountInfo, parameters: ["accountName" : accountName], method: .get, completion: completion)
    }
    static func getConvserionForEOS(completion: @escaping completionBlock){
        Router.shared.APIRouter(typeCall: .getEOSConversionToUSD, parameters: nil, method: .get, completion: completion)
    }
    
}

class Router {
    static let shared = Router()
    //api method to retrieve account info based on typeCall from server.
    func APIRouter(typeCall : typeOfCall , parameters: Dictionary<String,Any>?,method: httpMethod,completion: @escaping completionBlock){
        //Condition for url path for exchange rate and EOS data
        var urlString = ""
        if typeCall == typeOfCall.getEOSConversionToUSD {
            urlString = getURLPathForConversion(typeCall: typeCall.rawValue)
        }
        else{
        let accountName =  parameters?["accountName"] as? String
         urlString = getURLPathForEOSInfo(typeCall: typeCall.rawValue, accountName: accountName ?? "")
        }
        guard let url = URL(string: urlString) else { return}
        let session = URLSession.shared
        let timeOut = 30.0
        let request = NSMutableURLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: timeOut)
        request.httpMethod = method.rawValue
        if typeCall == typeOfCall.getEOSConversionToUSD{
            request.addValue(Constants.apiKeyForExchangeRate, forHTTPHeaderField: "X-CoinAPI-Key")
        }
        let dataTask =  session.dataTask(with: request as URLRequest)  { (data, response, error) in
            //check error type if error is not nil and return msg based on its type
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
            //Parse JSON
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
    //Append string for eosinfo call
    func getURLPathForEOSInfo(typeCall : String, accountName : String)-> String{
        let strURL =  Constants.baseURL + "apikey=" + Constants.apiKey + typeCall + "&account=" + accountName
        print(strURL)
        return strURL
        
    }
    //Append string for exchange rate
    func getURLPathForConversion(typeCall : String)-> String{
        let strURL =  Constants.baseURLForExchangeRate + typeCall
        print(strURL)
        return strURL
    }
    //Parse failure results
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
