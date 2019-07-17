//
//  EOSAccountModel.swift
//  DummyEOS
//
//  Created by Hamza Khan on 17/07/2019.
//  Copyright © 2019 Hamza Khan. All rights reserved.
//

import Foundation

struct  EOSAccountModel {
    let cpuWeight : String
    let netWeight : String
    
    let cpuAvailableResource: Int
    let cpuMaxResource : Int
    let cpuUsedResource : Int
    
    let netAvailableResource: Int
    let netMaxResource : Int
    let netUsedResource : Int
    
    let ramAvailableResource: Int
    let ramUsedResource : Int
    
    let balance : String
    let stakeToOthers : String
    let stakeToSelf : String
    let unstake : String
    
    
    func parseModelFromJson(){
        
    }
    
}
