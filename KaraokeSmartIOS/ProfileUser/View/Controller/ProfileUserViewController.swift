//
//  ProfileUserViewController.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/8/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import UIKit
import SwiftVideoBackground
import FirebaseAuth
import Firebase
import FirebaseDatabase


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
    var  databaseRef:DatabaseReference!
    
    
    @IBOutlet weak var viewBorder: UIView!
    @IBOutlet weak var imgProfileUser: UIImageView!
    @IBOutlet weak var lblUserNameArtistic: UILabel!
    @IBOutlet weak var lblNameUser: UILabel!
    @IBOutlet weak var lblDetailUser: UILabel!
    @IBOutlet weak var btnEditProfile: UIButton!
    @IBOutlet weak var tbProfile: UITableView!
    @IBOutlet weak var viewLoading: UIActivityIndicatorView!
    @IBOutlet weak var viewCountViews: UIView!
    
    private let errorPlaceholderView = UINib(nibName: "ErrorPlaceholderView", bundle: nil).instantiate(withOwner: self, options: nil).first as! ErrorPlaceholderView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        refreshView()
        profileUser()
        setPrimaryFilled(buttonStyle: btnEditProfile)
        viewCountViews.layer.cornerRadius = 14
        imgProfileUser.layer.cornerRadius = imgProfileUser.bounds.height / 2
        
        
        print("aCA 0 Iniciales")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigation()
          print("aCA A  Iniciales ")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("aCA B Iniciales ")
        tbProfile.reloadData()

    }
    
    
  
    
    private func setPrimaryFilled(buttonStyle:UIButton) {
        
        DispatchQueue.main.async(execute: {
            buttonStyle.titleLabel?.font = UIFont(name: "Prelo-Bold", size: 14)
            buttonStyle.layer.shadowColor = UIColor.clear.cgColor
            buttonStyle.layer.cornerRadius = 14
        })
    }
    
    func profileUser(){
        databaseRef = Database.database().reference()
                
                if let userID = Auth.auth().currentUser?.uid{
                    databaseRef.child("users/profile").child(userID).observeSingleEvent(of: .value) { (snapshot) in
                        
                        if let dictionary = snapshot.value as? NSDictionary,
                            let username = dictionary["username"] as? String,
                            let photoUrl = dictionary["photoUrl"] as? String,
                            let artistText = dictionary["artist"] as? String,
                            let textBio = dictionary["bio"] as? String,
                            let url = URL(string: photoUrl){
        //                let profileUser = UserProFile(username: username, photoUrl: url)
                            URLSession.shared.dataTask(with: url , completionHandler: { (data, response, error) in
                                if error != nil{
                                    print(error!)
                                    return
                                }
                                DispatchQueue.main.async {
                                    self.imgProfileUser.image = UIImage(data: data!)
                                }
                                }).resume()
                            self.lblUserNameArtistic.text = username
                            self.lblNameUser.text = artistText
                            self.lblDetailUser.text = textBio
                            
                        }
                    
                    }
                    self.tbProfile.reloadData()
                }
    }
    
    
    
    
    @IBAction func didTapEditProfile(_ sender: UIButton) {
        presenter.didTapProfileEdit()
    }
//    @IBAction func didTapSessionOff(_ sender: UIButton) {
//        try! Auth.auth().signOut()
//        self.dismiss(animated: false, completion: nil)
//        
//    }
}

extension ProfileUserViewController{
   
    func refreshView(){
        presenter.getProfiles()
    }
    
    func  setupNavigation(){
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setupView(){
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
        presenter.getProfiles()
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
        return presenter.getNumberOfRow()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cellMusic", for: indexPath) as! MusicKaraokeTableViewCell
        cell.labelDescription.text = "#\(presenter.getDescription(from: indexPath.row))"
        cell.labelTextDescriptionUser.text = ("\(presenter.getNameUserID(from: indexPath.row)) "+"canto "+"Luna de Octubre")
        DispatchQueue.global().async {
            let imageURL = URL(string: "\(self.presenter.getImgUser(from: indexPath.row))")
            guard let imageData = try? Data(contentsOf: imageURL!) else { return }
            DispatchQueue.main.async {
                let image = UIImage(data: imageData)
                cell.img_Profile.image = image
            }
        }
        if let urlPlay = URL(string: "\(presenter.getUrlMusic(from: indexPath.row))"){
            VideoBackground.shared.play(view: cell.view1, url: urlPlay, darkness: 0,isMuted: false,willLoopVideo:false,setAudioSessionAmbient:true, preventsDisplaySleepDuringVideoPlayback:true)
        }
        cell.isExclusiveTouch = true
        cell.contentView.isExclusiveTouch = true
        return cell
    }
}


