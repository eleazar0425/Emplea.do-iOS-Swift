//
//  NibIndentifiable.swift
//  Emplea.do
//
//  Created by Eleazar Estrella GB on 5/21/19.
//  Copyright © 2019 Eleazar Estrella. All rights reserved.
//

import Foundation
import UIKit

protocol NibIndentifiable {
    static var nibIdentifier: String { get }
}

extension UIViewController: NibIndentifiable {
    static var nibIdentifier: String {
        return String(describing: self)
    }
}

extension NibIndentifiable where Self: UIViewController {
    static func initFromNib() -> Self {
        return Self(nibName: nibIdentifier, bundle: nil)
    }
}
