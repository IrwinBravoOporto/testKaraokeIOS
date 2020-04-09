//
//  ErrorPlaceHolderView.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/8/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import UIKit



protocol ErrorPlaceholderViewDelegate: class {
    func didTapRetry()
}

class ErrorPlaceholderView: UIView {

    weak var delegate: ErrorPlaceholderViewDelegate?
    var  viewType:PlaceHolderErrorType!
    @IBOutlet weak var lblMessageError: UILabel!
    @IBOutlet var imgError: UIImageView!
    @IBOutlet weak var imgConstraintHeight: NSLayoutConstraint!
    @IBOutlet weak var imgConstraintTop: NSLayoutConstraint!
    @IBOutlet weak var imgRetry: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    @IBAction func didTapRetry(_ sender: UIButton) {
        guard let delegateRef = delegate else { return }
        delegateRef.didTapRetry()
    }
}

extension ErrorPlaceholderView {
    
    func initialSetup() {
        
        switch viewType {
        case .profile:
            lblMessageError.text = NSLocalizedString("withoutFavoritessError", comment: "withoutFavoritessError")
            imgError.image = UIImage(named: "")
            imgConstraintHeight.constant = 100
            imgConstraintTop.constant = 31
            imgRetry.isHidden = false
        default:
            lblMessageError.text = NSLocalizedString("defaultError", comment: "defaultError")
            imgConstraintHeight.constant = 100
            imgConstraintTop.constant = 31
            imgError.image = UIImage(named: "")
            imgRetry.isHidden = false
        }
        
    
    }
    
}

