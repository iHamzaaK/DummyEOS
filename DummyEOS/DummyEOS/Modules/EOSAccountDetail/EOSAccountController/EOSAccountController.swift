//
//  EOSAccountController.swift
//  DummyEOS
//
//  Created by Hamza Khan on 17/07/2019.
//  Copyright © 2019 Hamza Khan. All rights reserved.
//

import UIKit
import JGProgressHUD

class EOSAccountController: UIViewController {

    @IBOutlet weak var btnBuy : UIButton!
    @IBOutlet weak var btnSend : UIButton!
    @IBOutlet weak var btnReceive : UIButton!
    @IBOutlet weak var lblAccountNumber : UILabel!
    @IBOutlet weak var lblAccountBalance : UILabel!
    @IBOutlet weak var lblAmountUSD : UILabel!
    @IBOutlet weak var imgEOS : UIImageView!
    @IBOutlet weak var tblViewResource : UITableView!
    var eosViewModel : EOSAccountViewModel?
    let hud = JGProgressHUD(style: .dark)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customizeViews()
        self.customizeTableView()
        self.getAllEOSData()
    }

}
// MARK: Custom Functions
extension EOSAccountController{
    //Fetch all data from api
    private func getAllEOSData(){
        hud.textLabel.text = "Fetching data"
        let example = "helloworldjs"
        hud.show(in: self.view)
        EOSAccountSerivce.getUserAccountBalance(name: example) { (isSuccess, balanceModel, msg) in
            if isSuccess{
                guard let balanceModel = balanceModel else { return }
                EOSAccountSerivce.getUserResourceInfo(name: example, completion: { (isSuccess, resourceModel, msg) in
                    if isSuccess{
                        guard let resourceModel = resourceModel else { return }
                        self.eosViewModel = EOSAccountViewModel(eosBalance: balanceModel, eosResource: resourceModel)
                        self.setData()
                    }
                    else{
                        UtilFunctions.showAlert(Constants.errorTitle, message: msg, presenter: self)
                    }
                })
            }
            else{
                UtilFunctions.showAlert(Constants.errorTitle, message: msg, presenter: self)
            }
        }
    }
    //Displaying data after fetching from webservice.
    private func setData(){
        DispatchQueue.main.async {
            guard let eosViewModel = self.eosViewModel else { return }
            self.lblAccountBalance.text = String(eosViewModel.accountBalance ?? 0.0)
            self.lblAccountBalance.setFirstLetterCapitalizedBold()
            self.tblViewResource.reloadData()
        }
        getExchangeRateForEOS()
    }
    //TableView customization
    private func customizeTableView(){
        self.tblViewResource.estimatedRowHeight = EOSAccountRowEstimatedHeight.accountCellHeight.rawValue
        self.tblViewResource.rowHeight = UITableView.automaticDimension
        self.tblViewResource.sectionHeaderHeight = UITableView.automaticDimension;
        self.tblViewResource.estimatedSectionHeaderHeight = EOSAccountRowEstimatedHeight.accountHeaderHeight.rawValue
        UtilFunctions.registerNib(EOSAccountCells.resourceCellView.rawValue, cellIdentifier: EOSAccountCells.resourceCellView.rawValue, tblView: tblViewResource)
        UtilFunctions.registerNib(EOSAccountCells.resourceHeaderView.rawValue, cellIdentifier: EOSAccountCells.resourceHeaderView.rawValue, tblView: tblViewResource)
        tblViewResource.allowsSelection = false
    }
    //General method for customizing view of controller
    private func customizeViews(){
        //added shadow and corner radius for btnBuy, btnReceive and btnSend
        UtilFunctions.cornerRadiusAndShadowForButtons(button: btnBuy)
        UtilFunctions.cornerRadiusAndShadowForButtons(button: btnReceive)
        UtilFunctions.cornerRadiusAndShadowForButtons(button: btnSend)
    }
    //Get exchange rate for eos to usd
    func getExchangeRateForEOS(){
        EOSAccountSerivce.getConversionForEOSToUSD { (isSuccess, rate, msg) in
            if isSuccess{
                guard let eosViewModel = self.eosViewModel else { return }
                let usdPrice = rate * (eosViewModel.accountBalance ?? 0.0)
                self.eosViewModel?.accountBalanceUSD = String(usdPrice.rounded(toPlaces: 2)).convertIntoCurrency()
                DispatchQueue.main.async {
                    self.lblAmountUSD.text = eosViewModel.accountBalanceUSD
                    self.hud.dismiss(animated: false)
                }
            }
            else{
                DispatchQueue.main.async {
                    self.hud.dismiss(animated: false)
                }
            }
        }
    }
}
// MARK:  IBActions
extension EOSAccountController{
    
    @IBAction func didTapOnBuyBtn(sender: UIButton){
        UtilFunctions.showAlert("", message: Constants.comingSoon, presenter: self)
    }
    @IBAction func didTapOnSendBtn(sender: UIButton){
        UtilFunctions.showAlert("", message: Constants.comingSoon, presenter: self)
    }
    @IBAction func didTapOnReceiveBtn(sender: UIButton){
        UtilFunctions.showAlert("", message: Constants.comingSoon, presenter: self)
    }
    
}
// MARK: Tableview delegates and datasource
extension EOSAccountController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //if viewmodel is empty return 0
        guard let eosViewModel = self.eosViewModel else { return 0}
        return eosViewModel.getArrResourceCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EOSAccountCells.resourceCellView.rawValue, for: indexPath) as! EOSAccountTableViewCell
        cell.resourceTableModel = self.eosViewModel?.getArrResource()[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //setting up resourceHeaderViewCell as header for resourceTableView
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: EOSAccountCells.resourceHeaderView.rawValue) as! ResourceHeaderViewCell
        headerCell.lblStaked.text = self.eosViewModel?.cpuStaked
        return headerCell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}
