//
//  UILabel+AddImage.swift
//  Emplea.do
//
//  Created by Eleazar Estrella GB on 5/21/19.
//  Copyright © 2019 Eleazar Estrella. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func addImageWith(name: String) {
        
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: name)
        let attachmentString = NSAttributedString(attachment: attachment)
        
        guard let txt = self.text else {
            return
        }
        
        let strLabelText = NSAttributedString(string: txt)
        let mutableAttachmentString = NSMutableAttributedString(attributedString: attachmentString)
        mutableAttachmentString.append(strLabelText)
        self.attributedText = mutableAttachmentString
    }
    
    func removeImage() {
        let text = self.text
        self.attributedText = nil
        self.text = text
    }
}
