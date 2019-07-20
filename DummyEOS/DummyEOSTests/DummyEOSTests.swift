//
//  DummyEOSTests.swift
//  DummyEOSTests
//
//  Created by Hamza Khan on 19/07/2019.
//  Copyright © 2019 Hamza Khan. All rights reserved.
//

import XCTest
@testable import DummyEOS

class DummyEOSTests: XCTestCase {
    
    var eosAccountController : EOSAccountController!
    let sampleEOSBalance = EOSBalance.init(balance: "0.23423", stake_to_others: "0.0000", stake_to_self: "1.0000", unstake: "0.000")
    let sampleEOSCpu = EOSCpu(available: 1243, max: 2000, used: 800)
    let sampleEOSNet = EOSCpu(available: 2043, max: 3000, used: 1200)
    let sampleEOSRam = EOSRam(available: 3050, used: 2000)
    let sampleEOSStaked = EOSStaked(net_weight: "1000", cpu_weight: "1000")
    let sampleEOSUnStaked = EOSStaked(net_weight: "0.000", cpu_weight: "0.000")
    var sampleEOSResource : EOSResourceDataModel!
    var sampleEOSAccountViewModel : EOSAccountViewModel!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sampleEOSResource = EOSResourceDataModel(cpu: sampleEOSCpu, net: sampleEOSNet, ram: sampleEOSRam, staked: sampleEOSStaked, unstake: sampleEOSUnStaked)
        sampleEOSAccountViewModel = EOSAccountViewModel(eosBalance: sampleEOSBalance, eosResource: sampleEOSResource)
        let storyboard = UIStoryboard(name: ProjectStoryboards.main.rawValue, bundle: Bundle.main)
        guard let vc : EOSAccountController = storyboard.instantiateViewController(withIdentifier: ControllersList.eosAccountDetail.rawValue) as? EOSAccountController else{
            return XCTFail("Could not instantiate EOSAccountController")
        }
        eosAccountController = vc
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController.init(rootViewController: vc)
        _ = eosAccountController.view // To call viewDidLoad
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        eosAccountController = nil
    }
    //EOSAccount TableView not nil test
    func testControllerHasTableView() {
        XCTAssertNotNil(eosAccountController.tblViewResource,"Controller should have a tableview")
    }
    //EOSAccount TableView delegate test
    func testTableViewDelegateSetUpCorrectly() {
        XCTAssertTrue(eosAccountController.tblViewResource.delegate is EOSAccountController , "EOSAccountController does not conform to UITableView delegate protocol")
    }
     //EOSAccount TableView datasource test
    func testTableViewDataSourceSetUpCorrectly() {
        XCTAssertTrue(eosAccountController.tblViewResource.dataSource is EOSAccountController , "EOSAccountController does not conform to UITableView datasource protocol")
    }
    //EOSAccount TableView rows test
    func testCorrectNoOfRowsReturnAfterGettingAllData() {
        self.eosAccountController.eosViewModel = EOSAccountViewModel(eosBalance: sampleEOSBalance, eosResource: sampleEOSResource)
        self.eosAccountController.tblViewResource.reloadData()
        XCTAssertNotNil(self.eosAccountController.eosViewModel?.getArrResource)
        XCTAssertTrue(self.eosAccountController.tblViewResource.numberOfRows(inSection: 0) == self.eosAccountController.eosViewModel?.getArrResourceCount()  , "Table views rows should be equal to resources")
    }
    //User Account Balance api call test
    func testServiceCallForUserBalance()  {
        let expectation = self.expectation(description: "should recieve data")
        EOSAccountSerivce.getUserAccountBalance(name: "helloworldjs") { (isSuccess, balanceModel, msg) in
            if isSuccess{
                expectation.fulfill()
            }
            else{
                XCTFail("service failed")
            }
        }
        waitForExpectations(timeout: 20, handler: nil)
    }
    //Resource api call Test
    func testServiceCallForResource()  {
        let expectation = self.expectation(description: "should recieve data")
        EOSAccountSerivce.getUserResourceInfo(name: "helloworldjs") { (isSuccess, resourceModel, msg) in
            if isSuccess{
                expectation.fulfill()
            }
            else{
                XCTFail("service failed")
            }
        }
        waitForExpectations(timeout: 20, handler: nil)
    }
    //EOSAccountViewModel Test
    func testEOSAccountViewModel(){
        XCTAssertEqual(sampleEOSBalance.balance, String(sampleEOSAccountViewModel.accountBalance ?? 0.0))
        //CPU
        XCTAssertEqual(Double(sampleEOSCpu.available ?? 0), sampleEOSAccountViewModel.accountCPUResourceAvailable)
        XCTAssertEqual(Double(sampleEOSCpu.used ?? 0), sampleEOSAccountViewModel.accountCPUResourceUsed)
        XCTAssertEqual(Double(sampleEOSCpu.available ?? 0), sampleEOSAccountViewModel.accountCPUResourceAvailable)
        //NET
        XCTAssertEqual(Double(sampleEOSNet.available ?? 0), sampleEOSAccountViewModel.accountNETResourceAvailable)
        XCTAssertEqual(Double(sampleEOSNet.used ?? 0), sampleEOSAccountViewModel.accountNETResourceUsed)
        XCTAssertEqual(Double(sampleEOSNet.max ?? 0), sampleEOSAccountViewModel.accountNETResourceMax)
        //RAM
        XCTAssertEqual(Double(sampleEOSRam.available ?? 0), sampleEOSAccountViewModel.accountRamResourceAvailable)
        XCTAssertEqual(Double(sampleEOSRam.used ?? 0), sampleEOSAccountViewModel.accountRamResourceUsed)
        //array of resource not nil
        XCTAssertNotNil(sampleEOSAccountViewModel.getArrResource)
        
    }
}
