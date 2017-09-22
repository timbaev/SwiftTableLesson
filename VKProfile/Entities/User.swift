//
//  User.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 17.09.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

enum OnlineStatus: String {
    case offline = "Offline"
    case mobile = "Online (Моб.)"
    case computer = "Online"
    
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
    
    var info: UserInfo
}

struct UserInfo {
    var status: String
    var mainInfo: MainInfo
}

enum FamilyStatus: String {
    case notMarried = "Не женат"
    case havePartner = "Есть подруга"
    case betrothed = "Помолвлен"
    case married = "Женат"
    case complicated = "Всё сложно"
    case activelyLooking = "В активном поиске"
    case inLove = "Влюблён"
    case inCivilMarriage = "В гражданском браке"
}

struct MainInfo {
    var birthday: Date
    var hometown: String
    var placeOfStudy: String
    var familyStatus: FamilyStatus
    var parents: [String]
    var brothersAndSisters: [String]
    
    func toOrderedDictionary() -> [Int: [String:String]] {
        let dateFormat = "d MMM yyyy"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let dateString = dateFormatter.string(from: birthday)
        
        let parentsString = parents.joined(separator: ",")
        let brotherAndSistersString = brothersAndSisters.joined(separator: ",")
        
        return [0: ["День рождения":dateString], 1: ["Родной город":hometown], 2: ["Место учебы":placeOfStudy], 3: ["Семейное положение":familyStatus.rawValue], 4: ["Родители":parentsString], 5: ["Братья, сестры":brotherAndSistersString]]
    }
}
