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
    var accountBalance : Double?
    var accountCPUResourceAvailable : Double!
    var accountCPUResourceUsed : Double!
    var accountCPUResourceMax : Double!
    var accountRamResourceAvailable : Double!
    var accountRamResourceUsed : Double!
    var accountRamResourceMax : Double!
    var accountNETResourceAvailable : Double!
    var accountNETResourceUsed : Double!
    var accountNETResourceMax : Double!
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
    private var arrResource: [resourceTableModel]?
    
    //instantiate viewmodel
    init(eosBalance : EOSBalance, eosResource: EOSResourceDataModel){
        
        guard let cpuModel = eosResource.cpu, let ramModel = eosResource.ram , let netModel = eosResource.net, let stakedModel = eosResource.staked  else { return }
        //eos balance
        self.accountBalance = Double(eosBalance.balance ?? "") ?? 0.0.rounded(toPlaces: 4)
        //CPU resources
        self.accountCPUResourceAvailable = Double(cpuModel.available ?? 0)
        self.accountCPUResourceUsed = Double(cpuModel.used ?? 0)
        self.accountCPUResourceMax = Double(cpuModel.max ?? 0)
        //RAM resources
        self.accountRamResourceAvailable = Double(ramModel.available ?? 0)
        self.accountRamResourceUsed = Double(ramModel.used ?? 0)
        //NET resources
        self.accountNETResourceAvailable = Double(netModel.available ?? 0)
        self.accountNETResourceUsed = Double(netModel.used ?? 0)
        self.accountNETResourceMax = Double(netModel.max ?? 0)
        //Get Ram, net and cpu percentage
        self.ramPercentage = getPercentageAndSliderValForResource(used: (ramModel.used ?? 0) , available: (ramModel.available ?? 0)).0
        self.netPercentage = getPercentageAndSliderValForResource(used: (netModel.used ?? 0) , available: (netModel.available ?? 0)).0
        self.cpuPercentage = getPercentageAndSliderValForResource(used: (cpuModel.used ?? 0) , available: (cpuModel.available ?? 0)).0
        //Get progress slider val for ram, net and cpu
        self.ramSliderVal = getPercentageAndSliderValForResource(used: (ramModel.used ?? 0) , available: (ramModel.available ?? 0)).1
        self.netSliderVal = getPercentageAndSliderValForResource(used: (netModel.used ?? 0) , available: (netModel.available ?? 0)).1
        self.CPUSliderVal = getPercentageAndSliderValForResource(used: (cpuModel.used ?? 0) , available: (cpuModel.available ?? 0)).1
        //Staked values for CPU and NET
        self.netStaked = stakedModel.net_weight ?? ""
        self.cpuStaked = stakedModel.cpu_weight ?? ""
        //Adding values in array for resource table
        arrResource = [
                resourceTableModel(resourceName: "NET", resourcePercent: self.netPercentage, resourceUsed: self.accountNETResourceUsed, resourceAvailable: self.accountNETResourceAvailable, resourceSliderVal: self.netSliderVal, resourceStaked: self.netStaked),
                resourceTableModel(resourceName: "CPU", resourcePercent: self.cpuPercentage, resourceUsed: self.accountCPUResourceUsed, resourceAvailable: self.accountCPUResourceAvailable, resourceSliderVal: self.CPUSliderVal, resourceStaked: self.cpuStaked),
                resourceTableModel(resourceName: "RAM", resourcePercent: self.ramPercentage, resourceUsed: self.accountRamResourceUsed, resourceAvailable: self.accountRamResourceAvailable, resourceSliderVal: self.ramSliderVal, resourceStaked: "")
        ]
    }
    //A function which returns tuple of percentage and slider progress val
    private func getPercentageAndSliderValForResource(used: Int , available : Int)-> (String,Double){
        let sliderVal : Double = Double(used / available).rounded(toPlaces: 0)
        let strPercent = String(sliderVal * 100) + "%"
        return (strPercent,sliderVal)
    }
    //Function to get arrResource count
    func getArrResourceCount() -> Int{
        guard let arrResource = arrResource else { return 0 }
        return arrResource.count
    }
    //Function to get arrResource
    func getArrResource()-> [resourceTableModel]{
        guard let arrResource = arrResource else { return [] }
        return arrResource
    }
}
//Modele for resource table cells
class resourceTableModel {
    
    var strResourceName : String
    var strResourcePercent : String
    var strResourceUsed : Double
    var strResourceAvailable : Double
    var strResourceSliderVal : Double
    var strResourceStaked : String
    var sliderVal : Float
    var hideEOSImage : Bool = false
    init(resourceName : String , resourcePercent : String , resourceUsed : Double , resourceAvailable : Double , resourceSliderVal : Double , resourceStaked: String) {
        self.strResourceName = resourceName
        self.strResourcePercent = resourcePercent
        self.strResourceUsed = resourceUsed
        self.strResourceAvailable = resourceAvailable
        self.strResourceSliderVal = resourceSliderVal
        self.strResourceStaked = resourceStaked
        sliderVal = Float(resourceUsed/resourceAvailable)
        if strResourceName == "RAM"{
            hideEOSImage = true
        }
    }
    
}
