//
//  ProfileUserViewController.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/8/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import UIKit

enum PlaceHolderErrorType {
    case profile
}

protocol ProfileUserViewControllerProtocol:class,ViewProtocol {
    func failedContentShowPlaceHolder(type:PlaceHolderErrorType)
    func hideErrorView()
    func loadContent()
    func reloadData()
}

class ProfileUserViewController: UIViewController {
    
    var presenter:ProfileUserPresenterProtocol!
    var configurator = ProfileUserConfigurator()
    var viewData:ViewData?
    
    
    
    @IBOutlet weak var viewBorder: UIView!
    @IBOutlet weak var imgProfileUser: UIImageView!
    @IBOutlet weak var lblUserNameArtistic: UILabel!
    @IBOutlet weak var lblNameUser: UILabel!
    @IBOutlet weak var lblDetailUser: UILabel!
    @IBOutlet weak var btnEditProfile: UIButton!
    @IBOutlet weak var tbProfile: UITableView!
    @IBOutlet weak var viewLoading: UIActivityIndicatorView!
    
    private let errorPlaceholderView = UINib(nibName: "ErrorPlaceholderView", bundle: nil).instantiate(withOwner: self, options: nil).first as! ErrorPlaceholderView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewSetup()
        refreshView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigation()
    }
    
    
    @IBAction func didTapEditProfile(_ sender: UIButton) {
        presenter.didTapProfileEdit()
    }
}

extension ProfileUserViewController{
    func viewRefresh(){
        self.tbProfile.backgroundView = nil
        self.errorPlaceholderView.removeFromSuperview()
        presenter.getProfile()
    }
    
    func refreshView(){
        presenter.getProfile()
    }
    
    func  setupNavigation(){
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func initViewSetup(){
        configurator.configure(viewController: self)
    }
    private func setErrorState(type: PlaceHolderErrorType) {
        errorPlaceholderView.delegate = self
        errorPlaceholderView.viewType = type
        errorPlaceholderView.initialSetup()
        errorPlaceholderView.backgroundColor = .clear
        tbProfile.backgroundView = errorPlaceholderView
        tbProfile.reloadData()
    }
}

extension ProfileUserViewController:ErrorPlaceholderViewDelegate{
    func didTapRetry() {
        tbProfile.backgroundView = nil
        errorPlaceholderView.removeFromSuperview()
        presenter.getProfile()
    }
}

extension ProfileUserViewController:ProfileUserViewControllerProtocol{
    func failedContentShowPlaceHolder(type: PlaceHolderErrorType) {
        errorPlaceholderView.isHidden = false
        setErrorState(type: type)
    }
    
    func hideErrorView() {
        errorPlaceholderView.isHidden = true
        
    }
    func loadContent() {
        tbProfile.backgroundView = nil
        tbProfile.isHidden = false
        errorPlaceholderView.removeFromSuperview()
        tbProfile.reloadData()
    }
    
    func reloadData() {
        tbProfile.reloadData()
    }
    
    func startLoading() {
        viewLoading.startAnimating()
        
    }
    
    func finishLoading() {
        viewLoading.stopAnimating()
        
    }
    
}

extension ProfileUserViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cellMusic", for: indexPath) as! MusicKaraokeTableViewCell
        let url = URL(string: "https://s3.amazonaws.com/ks-records-test/media/records/2990/3654c78e9e_video_mixed.mp4")
        let urlRequest = URLRequest(url: url!)
        cell.webViewUrlMusic.load(urlRequest)
        cell.isExclusiveTouch = true
        cell.contentView.isExclusiveTouch = true
        return cell
    }
    
    
}


