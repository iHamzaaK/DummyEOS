//
//  Extensions.swift
//  DummyEOS
//
//  Created by Hamza Khan on 19/07/2019.
//  Copyright © 2019 Hamza Khan. All rights reserved.
//

import Foundation


extension Double {
        /// Rounds the double to decimal places value
        func rounded(toPlaces places:Int) -> Double {
            let divisor = pow(10.0, Double(places))
            return (self * divisor).rounded() / divisor
        }
    
}
extension String{
    func convertIntoCurrency()-> String{
        return "= " + self + " $"
    }
}

