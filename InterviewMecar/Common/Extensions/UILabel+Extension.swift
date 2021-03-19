//
//  UILabel+Extension.swift
//  InterviewMecar
//
//  Created by Cong Thanh on 3/19/21.
//

import UIKit

extension UILabel {
    func addCharacterSpacing(kernValue: Double = 0.5) {
    if let labelText = text, labelText.count > 0 {
      let attributedString = NSMutableAttributedString(string: labelText)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: attributedString.length - 1))
      attributedText = attributedString
    }
  }
}
