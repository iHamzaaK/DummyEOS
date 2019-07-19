//
//	EOSBalance.swift
//
//	Create by Hamza Khan on 18/7/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class EOSBalanceModel : Codable {
    let data : EOSBalance?
    let errmsg : String?
    let errno : Int?
}

class EOSBalance : Codable {
	let balance : String?
	let stake_to_others : String?
	let stake_to_self : String?
	let unstake : String?
}
