//
//  EOSAccountViewModel.swift
//  DummyEOS
//
//  Created by Hamza Khan on 17/07/2019.
//  Copyright © 2019 Hamza Khan. All rights reserved.
//

import Foundation

class EOSAccountViewModel {
    var accoutName : String!
    var accountBalance : String!
    var accountCPUResource : String!
    var accountRamResource : String!
    var accountNETResource : String!
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
    
    init(name : String , balance : String , cpuResource: String , ramResource: String , netResource : String , accountStaked : String , accountBalanceUSD : String , ramPercentage : String , cpuPercentage : String , netPercentage : String , maxRam : String , maxCPU : String , maxNet : String) {
        self.accoutName = name
        self.accountBalance = balance
        self.accountCPUResource = cpuResource
        self.accountRamResource = ramResource
        self.accountNETResource = netResource
        self.accountStaked = accountStaked
        self.accountBalanceUSD = accountBalanceUSD
        self.ramPercentage = ramPercentage
        self.cpuPercentage = cpuPercentage
        self.netPercentage = netPercentage
        self.maxRam = maxRam
        self.maxCPU = maxCPU
        self.maxNet = maxNet

    }
    
    
}
