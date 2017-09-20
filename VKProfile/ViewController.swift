//
//  ViewController.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 11.09.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

fileprivate enum BorderPosition {
    case top
    case bottom
    case right
    case left
}

fileprivate enum InfoType: String {
    case friends = "друг"
    case followers = "подпичсик"
    case groups = "группа"
    case photos = "фото"
    case videos = "видео"
    case audios = "аудио"
    case presents = "подарок"
    case files = "файл"
}

class ViewController: UIViewController {

    @IBOutlet weak var infoScrollView: UIScrollView!
    @IBOutlet weak var photoScrollView: UIScrollView!
    @IBOutlet var menuButtons: [UIButton]!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var onlineStatusLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var yearsLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet var infoButtons: [UIButton]!
    @IBOutlet weak var photosButton: UIButton!
    @IBOutlet var photos: [UIImageView]!
    
    var count = 0
    var user: User!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        user = generateUser()
        
        createStyles()
        setLabels()
    }
    
    private func createBorders(to view: UIView, on position: BorderPosition) {
        let borderWidth = CGFloat(2.0)
        let marginX = CGFloat(10)
        let borderLength = CGFloat(UIScreen.main.bounds.width - marginX * 2)
        let borderColor = UIColor(rgb: 0xdbd6d6).cgColor
        let borderMargin: CGFloat = 1.0
        let noneMargin:CGFloat = 0
        
        switch position {
        case .top:
            let borderTop = CALayer()
            borderTop.borderColor = borderColor
            borderTop.frame = CGRect(x: marginX, y: noneMargin, width: borderLength, height: borderMargin)
            borderTop.borderWidth = borderWidth
            
            view.layer.addSublayer(borderTop)
            view.layer.masksToBounds = true
            break
        case .bottom:
            let borderBottom = CALayer()
            borderBottom.borderColor = borderColor
            borderBottom.frame = CGRect(x: marginX, y: view.frame.height - borderMargin, width: borderLength, height: view.frame.height - borderMargin)
            borderBottom.borderWidth = borderWidth
            
            view.layer.addSublayer(borderBottom)
            view.layer.masksToBounds = true
            break
        case .right:
            let borderRight = CALayer()
            borderRight.borderColor = borderColor
            borderRight.frame = CGRect(x: view.frame.width - borderMargin, y: noneMargin, width: borderMargin, height: view.frame.height)
            borderRight.borderWidth = borderWidth
            
            view.layer.addSublayer(borderRight)
            break
        case .left:
            let borderLeft = CALayer()
            borderLeft.borderColor = borderColor
            borderLeft.frame = CGRect(x: noneMargin, y: noneMargin, width: borderMargin, height: view.frame.height)
            
            view.layer.addSublayer(borderLeft)
            break
        }
    }
    
    private func createStyles() {
        createBorders(to: infoScrollView, on: .bottom)
        createBorders(to: infoScrollView, on: .top)
        createBorders(to: photoScrollView, on: .bottom)
        createBorders(to: menuButtons[0], on: .right)
        createBorders(to: menuButtons[1], on: .right)
        
        self.navigationController?.navigationBar.barTintColor = UIColor(rgb: 0x3180d6)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        avatarImage.layer.cornerRadius = avatarImage.frame.size.width / 2
        avatarImage.clipsToBounds = true
        self.view.layoutIfNeeded()
    }
    
    private func generateUser() -> User {
        var user = UserInfoData.generateUser()
        for _ in 0 ..< 25 {
            user.followers.append(UserInfoData.generateUser())
        }
        user.followers[0].onlineStatus = .computer
        return user
    }
    
    private func setLabels() {
        let onlineMobile = "Online (Моб.)"
        let offline = "Offlien"
        let online = "Online"
        let year = "год"
        let years = "лет"
        let seperator = ","
        let photosText = "фотографии"
        
        self.title = user.name
        nameLabel.text = user.name + " " + user.surname
        
        switch user.onlineStatus {
        case .offline:
            onlineStatusLabel.text = offline
            break
        case .mobile:
            onlineStatusLabel.text = onlineMobile
            break
        case .computer:
            onlineStatusLabel.text = online
            break
        }
        
        ageLabel.text = String(user.age)
        if (user.age == 1) {
            yearsLabel.text = year
        } else {
            yearsLabel.text = user.age > 4 ? years : year + "а"
        }
        yearsLabel.text = yearsLabel.text! + seperator
        cityLabel.text = user.city
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let attributes: [String: Any] = [NSParagraphStyleAttributeName: paragraph]
        setTitle(with: infoButtons[0], type: .friends, count: user.friends, attributes: attributes)
        setTitle(with: infoButtons[1], type: .followers, count: user.followers.count, attributes: attributes)
        setTitle(with: infoButtons[2], type: .groups, count: user.groups, attributes: attributes)
        setTitle(with: infoButtons[3], type: .photos, count: user.photos.count, attributes: attributes)
        setTitle(with: infoButtons[4], type: .videos, count: user.videos, attributes: attributes)
        setTitle(with: infoButtons[5], type: .audios, count: user.audios, attributes: attributes)
        setTitle(with: infoButtons[6], type: .presents, count: user.presents, attributes: attributes)
        setTitle(with: infoButtons[7], type: .files, count: user.files, attributes: attributes)
        
        photosButton.setTitle("\(user.photos.count) " + photosText, for: .normal)
        photos.enumerated().forEach{ $0.element.image = user.photos[$0.offset] }
        avatarImage.image = user.profileImage
    }
    
    @IBAction func onInfoClick(_ sender: UIButton) {
        if (count == 5) {
            user = generateUser()
            setLabels()
            count = 0
        } else {
            count += 1
        }
    }
    
    private func setTitle(with button: UIButton, type: InfoType, count: Int, attributes: [String : Any]) {
        var title = type.rawValue
        let friends = "друзей"
        let group = "групп"
        let groups = "группы"
        let endingA = "а"
        let endingOV = "ов"
        
        switch type {
        case .friends:
            if (count % 10 > 4) {
                title = friends
            } else if (count % 10 != 1) {
                title += endingA
            }
            break
        case .followers:
            if (count % 10 > 4) {
                title += endingOV
            } else if (count % 10 != 1) {
                title += endingA
            }
            break
        case .groups:
            if (count % 10 > 4) {
                title = group
            }
            else if (count % 10 != 1) {
                title = groups
            }
            break
        case .presents:
            if (count % 10 > 4) {
                title += endingOV
            } else if (count % 10 != 1) {
                title += endingA
            }
            break
        case .files:
            if (count % 10 > 4) {
                title += endingOV
            } else if (count % 10 != 1) {
                title += endingA
            }
            break
        default:
            break
        }
        
        let attrString = NSAttributedString(string: "\(count)" + "\n" + title, attributes: attributes)
        button.setAttributedTitle(attrString, for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let followerTVC = segue.destination as! FollowersTableViewController
        followerTVC.followers = user.followers
    }
    
}

//extension to create color from HEX
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1)
    }
    
    convenience init(rgb: Int) {
        self.init(red: (rgb >> 16) & 0xFF, green: (rgb >> 8) & 0xFF, blue: rgb & 0xFF)
    }
}

