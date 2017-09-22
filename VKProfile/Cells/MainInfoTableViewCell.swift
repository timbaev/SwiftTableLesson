//
//  MainInfoTableViewCell.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 22.09.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

class MainInfoTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func prepareCell(with info: MainInfo, position: Int) {
        let orderedDictionaryInfo = info.toOrderedDictionary()
        if let dictionaryInfo = orderedDictionaryInfo[position] {
            let title = Array(dictionaryInfo.keys)[0]
            
            titleLabel.text = title
            infoLabel.text = dictionaryInfo[title]
        }
    }
    
}
