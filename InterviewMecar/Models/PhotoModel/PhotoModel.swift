//
//  PhotoModel.swift
//  InterviewMecar
//
//  Created by Cong Thanh on 3/21/21.
//

import Foundation
import SwiftyJSON

struct Author {
    var name: String
    var signature: String
    var avatar: String // string url for avatar
    
    init(data: JSON) {
        self.name = data["name"].stringValue
        self.signature = data["signature"].stringValue
        self.avatar = data["avatar"].stringValue
    }
    
    init(name: String = "", signature: String = "", avatar: String = "") {
        self.name = name
        self.signature = signature
        self.avatar = avatar
    }
}

struct PhotoModel {
    var photoName: String
    var url: String // string URL for photo
    var width: Int
    var height: Int
    var author: Author
    
    init(data: JSON) {
        self.photoName = data["name"].stringValue
        self.url = data["url"].stringValue
        self.width = data["width"].intValue
        self.height = data["height"].intValue
        self.author = Author(data: data["author"])
    }

    init(name: String = "",width: Int = 0, height: Int = 0, url: String) {
        self.photoName = name
        self.url = url
        self.width = width
        self.height = height
        self.author = Author()
    }
    
}


