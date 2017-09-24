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
    
    var accessoryButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryType = .disclosureIndicator
        accessoryButton = self.subviews.flatMap { $0 as? UIButton }.first
    }
    
    override func layoutSubviews() {
        let arrowPosition: CGFloat = 8
        
        super.layoutSubviews()
        accessoryButton.frame.origin.y = arrowPosition
    }
    
    func prepareCell(with presents: [Present]) {
        presentsCountLabel.text = "\(presents.count) \(EndingWord.getCorrectEnding(with: presents.count, and: DeclinationWordDictionary.present))"
        presentsImageView.forEach { $0.image = presents[0].image }
        
        presentsImageView.enumerated().forEach { $0.element.image = presents[$0.offset].image }
    }
    
}
