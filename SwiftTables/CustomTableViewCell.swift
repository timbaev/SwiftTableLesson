
//
//  CustomTableViewCell.swift
//  SwiftTables
//
//  Created by Ildar Zalyalov on 18.09.17.
//  Copyright © 2017 ru.itisIosLab. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!{
        didSet{
            self.nameLabel.sizeToFit()
        }
    }
   
    @IBOutlet weak var ageLabel: UILabel!

    
    func prepareCell(with user: User) {
        
        avatarImageView.image = UIImage(named: "1")
        nameLabel.text = user.name
        
        ageLabel.text = String(user.age)
    }
    
}
