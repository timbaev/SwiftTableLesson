//
//  UserInfoData.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 17.09.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

class UserInfoData {
    
    private static let names = ["Феликс", "Велислав", "Леонард", "Флорин", "Милонег", "Юджин"]
    private static let surnames = ["Трофимов", "Шилов", "Алексеев", "Гончарук", "Сидоров", "Горбачев"]
    private static let cities = ["Кумертау", "Павловск", "Дубна", "Осташков", "Минеральные Воды", "Благовещенск"]
    private static let photos = [#imageLiteral(resourceName: "album1"), #imageLiteral(resourceName: "album2"), #imageLiteral(resourceName: "album3"), #imageLiteral(resourceName: "album4"), #imageLiteral(resourceName: "album5"), #imageLiteral(resourceName: "album6")]
    private static let profilePhotos = [#imageLiteral(resourceName: "avatar1"), #imageLiteral(resourceName: "avatar2"), #imageLiteral(resourceName: "avatar3"), #imageLiteral(resourceName: "avatar4"), #imageLiteral(resourceName: "avatar5"), #imageLiteral(resourceName: "avatar6")]
    
    static func generateUser() -> User {
        let maxRandomValue: UInt32 = 1000
        
        let name = names[Int(arc4random_uniform(UInt32(names.count - 1)))]
        let surname = surnames[Int(arc4random_uniform(UInt32(surnames.count - 1)))]
        let online = OnlineStatus.statuses[Int(arc4random_uniform(2))]
        let age = Int(arc4random_uniform(99) + 1)
        let city = cities[Int(arc4random_uniform(UInt32(cities.count - 1)))]
        let friends = Int(arc4random_uniform(maxRandomValue))
        var photos = [UIImage]()
        for _ in 0 ..< 4 {
            photos.append(self.photos[Int(arc4random_uniform(UInt32(self.photos.count - 1)))])
        }
        let groups = Int(arc4random_uniform(maxRandomValue))
        let videos = Int(arc4random_uniform(maxRandomValue))
        let audios = Int(arc4random_uniform(maxRandomValue))
        let presents = Int(arc4random_uniform(maxRandomValue))
        let files = Int(arc4random_uniform(maxRandomValue))
        let avatar = profilePhotos[Int(arc4random_uniform(UInt32(profilePhotos.count - 1)))]
        
        let info = createUserInfo()
        
        return User(name: name, surname: surname, onlineStatus: online, age: age, city: city, friends: friends, followers: [User](), photos: photos, groups: groups, videos: videos, audios: audios, presents: presents, files: files, profileImage: avatar, info: info)
    }
    
    private static func createUserInfo() -> UserInfo {        
        var mainInformations = [MainInfo]()
        mainInformations.append(MainInfo(type: .birthday, info: "4 мая 1998"))
        mainInformations.append(MainInfo(type: .hometown, info: "Елабуга"))
        mainInformations.append(MainInfo(type: .placeOfStudy, info: "КФУ"))
        mainInformations.append(MainInfo(type: .familyStatus, info: FamilyStatus.notMarried.rawValue))
        mainInformations.append(MainInfo(type: .parents, info: "Мама, Папа"))
        mainInformations.append(MainInfo(type: .siblings, info: "Брат, Сестра"))
        
        var contacts = [Contact]()
        contacts.append(Contact(icon: #imageLiteral(resourceName: "phone"), type: .phone, info: "+7-917-255-55-55"))
        contacts.append(Contact(icon: #imageLiteral(resourceName: "home"), type: .city, info: "Казань"))
        contacts.append(Contact(icon: #imageLiteral(resourceName: "twitter"), type: .twitter, info: "Twitter"))
        contacts.append(Contact(icon: #imageLiteral(resourceName: "instagram"), type: .instagram, info: "Instagram"))
        contacts.append(Contact(icon: #imageLiteral(resourceName: "skype"), type: .skype, info: "Skype"))
        contacts.append(Contact(icon: #imageLiteral(resourceName: "vk"), type: .vk, info: "VK"))
        
        var professions = [Profession]()
        
        var dateComponents = DateComponents()
        dateComponents.year = 2017
        
        if let startDate = Calendar.current.date(from: dateComponents) {
            dateComponents.year = 2017
            if let endDate = Calendar.current.date(from: dateComponents) {
                professions.append(Profession(name: "Android developer", company: "IT-Lyceum", city: "Казань", startDate: startDate, endDate: endDate))
                professions.append(Profession(name: "iOS developer", company: "ITIS", city: "Казань", startDate: endDate, endDate: nil))
            }
        }
        
        let info = UserInfo(status: "I ❤️ Swift programming", main: mainInformations, contacts: contacts, professions: professions)
        return info
    }
}
