//
//  EOSAccountController.swift
//  DummyEOS
//
//  Created by Hamza Khan on 17/07/2019.
//  Copyright © 2019 Hamza Khan. All rights reserved.
//

import UIKit

class EOSAccountController: UIViewController {

//    @IBOutlet weak var btnBuy : UIButton!
//    @IBOutlet weak var btnSend : UIButton!
//    @IBOutlet weak var btnReceive : UIButton!
//
//    @IBOutlet weak var lblAccountNumber : UILabel!
//    @IBOutlet weak var lblAccountBalance : UILabel!
//    @IBOutlet weak var lblAmountUSD : UILabel!
//
//    @IBOutlet weak var lblNetResource : UILabel!
//    @IBOutlet weak var lblRamResource : UILabel!
//    @IBOutlet weak var lblCPUResource : UILabel!

    var eosViewModel : EOSAccountViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let example = "helloworldjs"
        EOSAccountSerivce.getUserAccountBalance(name: example) { (isSuccess, balanceModel, msg) in
            if isSuccess{
                guard let balanceModel = balanceModel else { return }
                EOSAccountSerivce.getUserResourceInfo(name: example, completion: { (isSuccess, resourceModel, msg) in
                    if isSuccess{
                        guard let resourceModel = resourceModel else { return }

                        self.eosViewModel = EOSAccountViewModel(eosBalance: balanceModel, eosResource: resourceModel)
                        
                        print(self.eosViewModel.accountBalance)
                        print(self.eosViewModel.cpuPercentage)
                        print(self.eosViewModel.ramSliderVal)
                        print(self.eosViewModel.netStaked)
                        print(self.eosViewModel.accountNETResourceUsed)
                       
                    }
                })
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateViewModel), name: Notification.Name("exchangeRate"), object: nil)
//        EOSAccountSerivce.getAccountInfo(name: "helloworldjs") { (isSuccess, model, msg) in
//            if isSuccess{
//                print(msg)
//            }
//        }
//        EOSAccountSerivce.getUserResourceInfo(name: "helloworldjs") { (isSuccess, model, msg) in
//            if isSuccess{
//                EOSAccountSerivce.getUserAccountBalance(name: "helloworldjs", completion: { (isSuccess, model, msg) in
//                    print(msg)
//                })
//                print(msg)
//            }
//        }
    }

}
extension EOSAccountController{
    @objc func updateViewModel(){
        DispatchQueue.main.async {
            let rate = (UIApplication.shared.delegate as! AppDelegate).exchangeRateUSD
            let usdPrice = rate * self.eosViewModel.accountBalance
            self.eosViewModel.accountBalanceUSD = String(usdPrice) + "$"
        }
      
    }
}
