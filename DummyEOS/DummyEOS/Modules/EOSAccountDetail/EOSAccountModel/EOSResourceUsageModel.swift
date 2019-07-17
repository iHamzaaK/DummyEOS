//
//	EOSResourceUsageModel.swift
//
//	Create by Hamza Khan on 18/7/2019
//	Copyright © 2019. All rights reserved.


import Foundation

class EOSResourceUsageModel : Codable {
	let data : EOSData?
	let errmsg : String?
	let errno : Int?
}

class EOSStaked : Codable {
    let cpuWeight : String?
    let netWeight : String?
}

class EOSRam : Codable {
    let available : Int?
    let used : Int?
}

class EOSData : Codable {
    let cpu : EOSCpu?
    let net : EOSCpu?
    let ram : EOSRam?
    let staked : EOSStaked?
    let unstake : EOSStaked?
}

class EOSCpu : Codable {
    let available : Int?
    let max : Int?
    let used : Int?
}
