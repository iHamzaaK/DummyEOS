//
//  UtilFunctions.swift
//  DummyEOS
//
//  Created by Hamza Khan on 18/07/2019.
//  Copyright © 2019 Hamza Khan. All rights reserved.
//

import Foundation
import UIKit
class UtilFunctions{

    static func cornerRadiusAndShadowForButtons(button : UIButton){
        button.layer.cornerRadius = 5
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 4.0
    }
    static func showAlert(_ title : String , message : String, presenter : UIViewController){
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction.init(title: "Ok", style: .default) { (action) in
            
        }
        alert.addAction(action)
        
        presenter.present(alert, animated: true, completion: nil)
    }
    
    static func registerNib(_ nibName : String, cellIdentifier : String , tblView : UITableView){
        let nib = UINib(nibName: nibName, bundle: nil)
        tblView.register(nib, forCellReuseIdentifier: cellIdentifier)
    }
}
