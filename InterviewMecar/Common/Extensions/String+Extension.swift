//
//  String+Extension.swift
//  InterviewMecar
//
//  Created by Cong Thanh on 3/19/21.
//

import UIKit

extension String {
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }

    func localized() -> String {
        let path = Bundle.main.path(forResource: AppConfigure.currentLang.rawValue, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}
