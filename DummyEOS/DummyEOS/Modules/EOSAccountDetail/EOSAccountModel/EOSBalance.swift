//
//	EOSBalance.swift
//
//	Create by Hamza Khan on 18/7/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


struct EOSBalanceModel : Codable {
    let data : EOSBalance?
    let errmsg : String?
    let errno : Int?
}

struct EOSBalance : Codable {
	let balance : String?
	let stake_to_others : String?
	let stake_to_self : String?
	let unstake : String?
    
//    init(balance : String , stake_to_others : String , stake_to_self : String , unstake : String ) {
//        self.balance = balance
//        self.stake_to_self = stake_to_self
//        self.stake_to_others = stake_to_others
//        self.unstake = unstake
//    }
}
