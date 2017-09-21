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
        
        avatarImage.roundCorners()
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
        let photo = "фото"
        let audio = "аудио"
        let video = "видео"
        let seperator = ","
        
        self.title = user.name
        nameLabel.text = user.name + " " + user.surname
        onlineStatusLabel.text = user.onlineStatus.rawValue
        
        ageLabel.text = String(user.age)
        yearsLabel.text = EndingWord.getCorrectEnding(with: user.age, and: DeclinationWordDictionary.age) + seperator
        cityLabel.text = user.city
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let attributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey(rawValue: NSAttributedStringKey.paragraphStyle.rawValue): paragraph]
        setTitle(with: infoButtons[0], count: user.friends, declinationWord: DeclinationWordDictionary.friend, attributes: attributes)
        setTitle(with: infoButtons[1], count: user.followers.count, declinationWord: DeclinationWordDictionary.follower, attributes: attributes)
        setTitle(with: infoButtons[2], count: user.groups, declinationWord: DeclinationWordDictionary.group, attributes: attributes)
        setTitle(with: infoButtons[3], count: user.photos.count, word: photo, attributes: attributes)
        setTitle(with: infoButtons[4], count: user.videos, word: video, attributes: attributes)
        setTitle(with: infoButtons[5], count: user.audios, word: audio, attributes: attributes)
        setTitle(with: infoButtons[6], count: user.presents, declinationWord: DeclinationWordDictionary.present, attributes: attributes)
        setTitle(with: infoButtons[7], count: user.files, declinationWord: DeclinationWordDictionary.file, attributes: attributes)
        
        let photoCount = user.photos.count
        let photoTitle = EndingWord.getCorrectEnding(with: photoCount, and: DeclinationWordDictionary.photograph)
        photosButton.setTitle("\(photoCount) " + photoTitle, for: .normal)
        
        photos.enumerated().forEach{ $0.element.image = user.photos[$0.offset] }
        avatarImage.image = user.profileImage
    }
    
    private func setTitle(with button: UIButton, count: Int, declinationWord: DeclinationWord, attributes: [NSAttributedStringKey : Any]) {
        let title = EndingWord.getCorrectEnding(with: count, and: declinationWord)
        let attrString = NSAttributedString(string: "\(count)" + "\n" + title, attributes: attributes)
        button.setAttributedTitle(attrString, for: .normal)
    }
    
    private func setTitle(with button: UIButton, count: Int, word: String, attributes: [NSAttributedStringKey : Any]) {
        let attrString = NSAttributedString(string: "\(count)" + "\n" + word, attributes: attributes)
        button.setAttributedTitle(attrString, for: .normal)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let infoIdentifier = "infoSegue"
        let followersIdentifier = "followersSegue"
        
        if (segue.identifier == followersIdentifier) {
            let followerTVC = segue.destination as! FollowersTableViewController
            followerTVC.followers = user.followers
        } else if (segue.identifier == infoIdentifier) {
            let backItem = UIBarButtonItem()
            self.navigationItem.backBarButtonItem = backItem
            
            let infoTVC = segue.destination as! InfoTableViewController
            infoTVC.user = user
        }
        
    }
    
}










