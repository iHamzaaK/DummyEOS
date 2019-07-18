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
    var accountBalance : Double!
    
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
    var netStaked : String!
    var cpuStaked : String!

    var accountBalanceUSD : String!
    
    var ramPercentage : String!
    var cpuPercentage : String!
    var netPercentage : String!
    
    var ramSliderVal : Double!
    var CPUSliderVal : Double!
    var netSliderVal : Double!
    
    
    
    init(eosBalance : EOSBalance, eosResource: EOSResourceDataModel){
        
        guard let cpuModel = eosResource.cpu, let ramModel = eosResource.ram , let netModel = eosResource.net, let stakedModel = eosResource.staked  else { return }

        self.accountBalance = Double(eosBalance.balance ?? "") ?? 0.0
        self.accountCPUResourceAvailable = cpuModel.available ?? 0
        self.accountCPUResourceUsed = cpuModel.used ?? 0
        self.accountCPUResourceMax = cpuModel.max ?? 0
        
        self.accountRamResourceAvailable = ramModel.available ?? 0
        self.accountRamResourceUsed = ramModel.used ?? 0
//        self.accountRamResourceMax = eosResource.data?.ram?
        
        self.accountNETResourceAvailable = netModel.available ?? 0
        self.accountNETResourceUsed = netModel.used ?? 0
        self.accountNETResourceMax = netModel.max ?? 0
        
        
       
      
        
        self.ramPercentage = getPercentageAndSliderValForResource(used: (ramModel.used ?? 0) , available: (ramModel.available ?? 0)).0
        self.netPercentage = getPercentageAndSliderValForResource(used: (netModel.used ?? 0) , available: (netModel.available ?? 0)).0
        self.cpuPercentage = getPercentageAndSliderValForResource(used: (cpuModel.used ?? 0) , available: (cpuModel.available ?? 0)).0
        
        self.ramSliderVal = getPercentageAndSliderValForResource(used: (ramModel.used ?? 0) , available: (ramModel.available ?? 0)).1
        self.netSliderVal = getPercentageAndSliderValForResource(used: (netModel.used ?? 0) , available: (netModel.available ?? 0)).1
        self.CPUSliderVal = getPercentageAndSliderValForResource(used: (cpuModel.used ?? 0) , available: (cpuModel.available ?? 0)).1
        
        self.netStaked = stakedModel.netWeight ?? ""
        self.cpuStaked = stakedModel.cpuWeight ?? ""



        
    }
    
    func getPercentageAndSliderValForResource(used: Int , available : Int)-> (String,Double){
        let sliderVal : Double = Double(used / available)
        let strPercent = String(sliderVal * 100) + "%"
        return (strPercent,sliderVal)
    }
    
    

   
}
