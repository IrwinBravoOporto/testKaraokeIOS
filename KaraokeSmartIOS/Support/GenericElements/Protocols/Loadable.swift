//
//  Loadable.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/9/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import Foundation

@objc protocol Loadable {
    func startLoading()
    func finishLoading()
    func loadContent()
    @objc optional func failedLoadingNotification()
    @objc optional func failedLoadingContent()
}

protocol ViewProtocol: Loadable {
}

@objc protocol ViewPresenterProtocol {
    func viewDidLoad()
    @objc optional func viewWillAppear()
}
