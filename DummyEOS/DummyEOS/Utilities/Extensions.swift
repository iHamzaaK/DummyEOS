//
//  Extensions.swift
//  DummyEOS
//
//  Created by Hamza Khan on 19/07/2019.
//  Copyright © 2019 Hamza Khan. All rights reserved.
//

import Foundation
import UIKit

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

extension UILabel {
    func setFirstLetterCapitalizedBold() {
        if let labelText = self.text {
        if labelText.count > 0 {
            let attText = NSMutableAttributedString(string: String(labelText.first!) + String(labelText.dropFirst()))
            attText.setAttributes([NSAttributedString.Key.font:UIFont.init(name: "HelveticaNeue-Bold", size: 48)], range: NSRange(location: 0, length: 1))
            attributedText = attText
        }
    }
    }
}
