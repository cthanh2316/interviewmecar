//
//  Constant.swift
//  InterviewMecar
//
//  Created by Cong Thanh on 3/19/21.
//

import UIKit
import SwiftyJSON

struct ScreenSize {
    static let WIDTH: CGFloat         = UIScreen.main.bounds.size.width
    static let HEIGHT: CGFloat        = UIScreen.main.bounds.size.height
}

class Utils {
    static func parseJsonFromFile(filename: String?) -> JSON {
        var jsonObj = JSON()
        if let path = Bundle.main.path(forResource: filename, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                jsonObj = try JSON(data: data)
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
        return jsonObj
    }
}
