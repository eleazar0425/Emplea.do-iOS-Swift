//
//  BadgeButton.swift
//  Emplea.do
//
//  Created by Eleazar Estrella GB on 5/22/19.
//  Copyright © 2019 Eleazar Estrella. All rights reserved.
//

import Foundation
import UIKit

class BadgeButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateAppearance()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updateAppearance()
    }
    
    func updateAppearance(){
        self.backgroundColor = UIColor.hexStringToUIColor(hex: Constants.Colors.primaryColor)
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 2
        self.setTitleColor(.white, for: .normal)
    }
}
