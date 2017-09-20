//
//  User.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 17.09.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

enum OnlineStatus {
    case offline
    case mobile
    case computer
    
    static let statuses = [offline, mobile, computer]
}

struct User {
    var name: String
    var surname: String
    var onlineStatus: OnlineStatus
    var age: Int
    var city: String
    var friends: Int
    var followers: [User]
    var photos: [UIImage]
    var groups: Int
    var videos: Int
    var audios: Int
    var presents: Int
    var files: Int
    var profileImage: UIImage
}
