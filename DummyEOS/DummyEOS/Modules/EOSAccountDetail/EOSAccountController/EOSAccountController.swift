//
//  EOSAccountController.swift
//  DummyEOS
//
//  Created by Hamza Khan on 17/07/2019.
//  Copyright © 2019 Hamza Khan. All rights reserved.
//

import UIKit

class EOSAccountController: UIViewController {

    @IBOutlet weak var btnBuy : UIButton!
    @IBOutlet weak var btnSend : UIButton!
    @IBOutlet weak var btnReceive : UIButton!

    @IBOutlet weak var lblAccountNumber : UILabel!
    @IBOutlet weak var lblAccountBalance : UILabel!
    @IBOutlet weak var lblAmountUSD : UILabel!
    @IBOutlet weak var imgEOS : UIImageView!

    @IBOutlet weak var tblViewResource : UITableView!

//    @IBOutlet weak var lblNetResource : UILabel!
//    @IBOutlet weak var lblRamResource : UILabel!
//    @IBOutlet weak var lblCPUResource : UILabel!

    var eosViewModel : EOSAccountViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customizeViewForButtons()
        self.customizeTableView()
        
        let example = "helloworldjs"
        EOSAccountSerivce.getUserAccountBalance(name: example) { (isSuccess, balanceModel, msg) in
            if isSuccess{
                guard let balanceModel = balanceModel else { return }
                EOSAccountSerivce.getUserResourceInfo(name: example, completion: { (isSuccess, resourceModel, msg) in
                    if isSuccess{
                        guard let resourceModel = resourceModel else { return }
                        self.eosViewModel = EOSAccountViewModel(eosBalance: balanceModel, eosResource: resourceModel)
                        self.setData()
                    }
                })
            }
        }
    }

}
extension EOSAccountController{
    
    private func setData(){
        DispatchQueue.main.async {
            self.lblAccountBalance.text = String(self.eosViewModel.accountBalance ?? 0.0)
            self.tblViewResource.delegate = self
            self.tblViewResource.dataSource = self
            self.tblViewResource.reloadData()
        }
        getExchangeRateForEOS()
    }
    
    private func customizeTableView(){
        self.tblViewResource.estimatedRowHeight = 80
        self.tblViewResource.rowHeight = UITableView.automaticDimension
        self.tblViewResource.sectionHeaderHeight = UITableView.automaticDimension;
        self.tblViewResource.estimatedSectionHeaderHeight = 70

        let nib = UINib(nibName: "ResourceCellView", bundle: nil)
        tblViewResource.register(nib, forCellReuseIdentifier: "ResourceCellView")
        let nib2 = UINib(nibName: "ResourceHeaderView", bundle: nil)
        tblViewResource.register(nib2, forCellReuseIdentifier: "ResourceHeaderView")
        tblViewResource.allowsSelection = false
    }
    
    private func customizeViewForButtons(){
        UtilFunctions.cornerRadiusAndShadowForButtons(button: btnBuy)
        UtilFunctions.cornerRadiusAndShadowForButtons(button: btnReceive)
        UtilFunctions.cornerRadiusAndShadowForButtons(button: btnSend)
    }
    
    func getExchangeRateForEOS(){
        EOSAccountSerivce.getConversionForEOSToUSD { (isSuccess, rate, msg) in
            if isSuccess{
                let usdPrice = rate * (self.eosViewModel.accountBalance ?? 0.0)
                self.eosViewModel.accountBalanceUSD = String(usdPrice.rounded(toPlaces: 2)).convertIntoCurrency()
                DispatchQueue.main.async {
                    self.lblAmountUSD.text = self.eosViewModel.accountBalanceUSD
                }
            }
            else{
                self.getExchangeRateForEOS()
            }
        }
    }
}

extension EOSAccountController{
    
    @IBAction func didTapOnBuyBtn(sender: UIButton){
        UtilFunctions.showAlert("", message: "Coming Soon", presenter: self)
    }
    @IBAction func didTapOnSendBtn(sender: UIButton){
        UtilFunctions.showAlert("", message: "Coming Soon", presenter: self)
    }
    @IBAction func didTapOnReceiveBtn(sender: UIButton){
        UtilFunctions.showAlert("", message: "Coming Soon", presenter: self)
    }
    
}

extension EOSAccountController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eosViewModel.getArrResourceCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResourceCellView", for: indexPath) as! EOSAccountTableViewCell
        cell.resourceTableModel = self.eosViewModel.getArrResource()[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: "ResourceHeaderView") as! ResourceHeaderViewCell
        
        headerCell.lblStaked.text = self.eosViewModel.cpuStaked
        return headerCell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}
