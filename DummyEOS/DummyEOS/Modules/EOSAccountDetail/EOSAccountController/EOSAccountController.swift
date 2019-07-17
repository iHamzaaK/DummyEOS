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
    
    @IBOutlet weak var lblNetResource : UILabel!
    @IBOutlet weak var lblRamResource : UILabel!
    @IBOutlet weak var lblCPUResource : UILabel!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
