//
//  MusicKaraokeTableViewCell.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/8/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import UIKit

class MusicKaraokeTableViewCell: UITableViewCell {
    @IBOutlet weak var img_Profile: UIImageView!
    @IBOutlet weak var labelTextDescriptionUser: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var view1: UIView!


    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        img_Profile.layer.cornerRadius = img_Profile.bounds.size.width / 2.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    
}
