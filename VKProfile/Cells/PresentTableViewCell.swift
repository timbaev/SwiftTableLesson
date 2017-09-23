//
//  PresentTableViewCell.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 23.09.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

class PresentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var presentsCountLabel: UILabel!
    @IBOutlet var presentsImageView: [UIImageView]!
    @IBOutlet weak var arrowImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        arrowImageView.image = arrowImageView.image!.withRenderingMode(.alwaysTemplate)
        arrowImageView.tintColor = UIColor.darkGray
    }
    
    func prepareCell(with presents: [Present]) {
        presentsCountLabel.text = "\(presents.count) \(EndingWord.getCorrectEnding(with: presents.count, and: DeclinationWordDictionary.present))"
        for presentImageView in presentsImageView {
            presentImageView.image = presents[0].image
        }
        
        presentsImageView.enumerated().forEach { $0.element.image = presents[$0.offset].image }
    }
    
}
