//
//  AppConfigure.swift
//  InterviewMecar
//
//  Created by Cong Thanh on 3/19/21.
//

import Foundation

struct AppConfigure {
    static var currentLang : String {
        get {
            guard let lang = UserDefaults.standard.value(forKey: AppConfig.Language.rawValue) else {
                return "en"
            }
            return lang as! String
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: AppConfig.Language.rawValue)
        }
    }
}
