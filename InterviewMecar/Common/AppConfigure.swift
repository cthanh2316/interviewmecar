//
//  AppConfigure.swift
//  InterviewMecar
//
//  Created by Cong Thanh on 3/19/21.
//

import Foundation

struct AppConfigure {
    static var currentLang : Languages {
        get {
            guard let lang = UserDefaults.standard.value(forKey: AppConfig.LanguagesKey.rawValue) else {
                return Languages.english
            }
            return Languages(rawValue: lang as! String) ?? .english
        }
        set {
            UserDefaults.standard.setValue(newValue.rawValue, forKey: AppConfig.LanguagesKey.rawValue)
        }
    }
}
