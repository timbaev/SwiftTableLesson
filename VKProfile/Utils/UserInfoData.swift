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
        
        return User(name: name, surname: surname, onlineStatus: online, age: age, city: city, friends: friends, followers: [User](), photos: photos, groups: groups, videos: videos, audios: audios, presents: presents, files: files, profileImage: avatar)
    }
}
