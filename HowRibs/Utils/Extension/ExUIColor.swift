//
//  ExUIColor.swift
//  HowRibs
//
//  Created by Jae hyung Kim on 9/8/25.
//

import UIKit.UIColor

extension UIColor {
    
    static var random: UIColor {
        return UIColor(
            red: .random(
                in: 0...1
            ),
            green: .random(
                in: 0...1
            ),
            blue: .random(
                in: 0...1
            ),
                alpha: 1.0
        )
    }
}
