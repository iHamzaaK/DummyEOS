//
//	EOSResourceUsageModel.swift
//
//	Create by Hamza Khan on 18/7/2019
//	Copyright © 2019. All rights reserved.


import Foundation

struct EOSResourceUsageModel : Codable {
	let data : EOSResourceDataModel?
	let errmsg : String?
	let errno : Int?
}

struct EOSStaked : Codable {
    let net_weight : String?
    let cpu_weight : String?
}

struct EOSRam : Codable {
    let available : Int?
    let used : Int?
}

struct EOSResourceDataModel : Codable {
    let cpu : EOSCpu?
    let net : EOSCpu?
    let ram : EOSRam?
    let staked : EOSStaked?
    let unstake : EOSStaked?
}

struct EOSCpu : Codable {
    let available : Int?
    let max : Int?
    let used : Int?
}
