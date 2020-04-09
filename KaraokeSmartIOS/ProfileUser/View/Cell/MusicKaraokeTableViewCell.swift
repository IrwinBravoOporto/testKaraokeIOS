//
//  MusicKaraokeTableViewCell.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/8/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import UIKit
import WebKit

class MusicKaraokeTableViewCell: UITableViewCell {
    @IBOutlet weak var img_Profile: UIImageView!
    @IBOutlet weak var labelTextDescriptionUser: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var webViewUrlMusic: WKWebView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
