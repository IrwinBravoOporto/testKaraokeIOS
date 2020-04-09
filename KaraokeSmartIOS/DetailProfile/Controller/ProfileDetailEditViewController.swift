//
//  ProfileDetailEditViewController.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/8/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import UIKit

class ProfileDetailEditViewController: UIViewController {
    
//    var presenter: ProfileDetailEditPresenterProtocol!
//    let configurator = ProfileDetailEditConfigurator()
    var viewData: ViewData?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigation()
        setupNavigationRight()
    }
    
    func setupNavigation(){
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        //title = presenter.getTitle()
        let back = UIBarButtonItem(image: UIImage(named: "img_back"), style: .plain, target: self, action: #selector(didTapBackButton))
        self.navigationItem.setLeftBarButton(back, animated: false)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    func setupNavigationRight(){
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        //title = presenter.getTitle()
        let back = UIBarButtonItem(image: UIImage(named: "img_back"), style: .plain, target: self, action: #selector(didTapCheck))
        self.navigationItem.setRightBarButton(back, animated: false)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    @objc func didTapBackButton(){
//        presenter.goToPreviousView()
    }
    
     @objc func didTapCheck(){
    //        presenter.goToPreviousView()
        }


}
