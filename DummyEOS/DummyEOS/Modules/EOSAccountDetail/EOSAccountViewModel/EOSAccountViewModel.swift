//
//  EOSAccountViewModel.swift
//  DummyEOS
//
//  Created by Hamza Khan on 17/07/2019.
//  Copyright © 2019 Hamza Khan. All rights reserved.
//

import Foundation
import SwiftyJSON

class EOSAccountViewModel {
    var accoutName : String!
    var accountBalance : String!
    
    var accountCPUResourceAvailable : Int!
    var accountCPUResourceUsed : Int!
    var accountCPUResourceMax : Int!
    
    var accountRamResourceAvailable : Int!
    var accountRamResourceUsed : Int!
    var accountRamResourceMax : Int!
    
    var accountNETResourceAvailable : Int!
    var accountNETResourceUsed : Int!
    var accountNETResourceMax : Int!
    
    var accountStaked : String!
    var accountBalanceUSD : String!
    var ramPercentage : String!
    var cpuPercentage : String!
    var netPercentage : String!
    var maxRam : String!
    var maxCPU: String!
    var maxNet : String!
    var ramSliderVal : String!
    var CPUSliderVal : String!
    var netSliderVal : String!
    
    
    init(eosBalance : EOSBalanceModel, eosResource: EOSResourceUsageModel){
        self.accountBalance = eosBalance.data?.balance ?? ""
        self.accountCPUResourceAvailable = eosResource.data?.cpu?.available ?? 0
        self.accountCPUResourceUsed = eosResource.data?.cpu?.used ?? 0
        self.accountCPUResourceMax = eosResource.data?.cpu?.max ?? 0
        
        self.accountRamResourceAvailable = eosResource.data?.ram?.available ?? 0
        self.accountRamResourceUsed = eosResource.data?.ram?.used ?? 0
//        self.accountRamResourceMax = eosResource.data?.ram?
        
        self.accountNETResourceAvailable = eosResource.data?.net?.available ?? 0
        self.accountNETResourceUsed = eosResource.data?.net?.used ?? 0
        self.accountNETResourceMax = eosResource.data?.net?.max ?? 0
        
        
        
        
        
    }
    
//    init(eosAccount : EOSAccountModel) {
//        self.accoutName = eosAccount.strName
//        self.accountBalance = balance
//        self.accountCPUResource = cpuResource
//        self.accountRamResource = ramResource
//        self.accountNETResource = netResource
//        self.accountStaked = accountStaked
//        self.accountBalanceUSD = accountBalanceUSD
//        self.ramPercentage = ramPercentage
//        self.cpuPercentage = cpuPercentage
//        self.netPercentage = netPercentage
//        self.maxRam = maxRam
//        self.maxCPU = maxCPU
//        self.maxNet = maxNet
//    }
    
//    func parseModel(e)
    
   
}
