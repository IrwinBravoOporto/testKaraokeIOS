//
//  ProfileDetailEditViewController.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/8/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SDWebImage

protocol ProfileDetailEditViewControllerProtocol:class{
    func cleanData()
}

class ProfileDetailEditViewController: UIViewController {
    
    var presenter: ProfileDetailEditPresenterProtocol!
    let configurator = ProfileDetailEditConfigurator()
    var viewData: ViewData?
    
    var databaseRef:DatabaseReference!
    var storageRef:StorageReference!
    
    @IBOutlet weak var btnEditImg: UIButton!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtFieldNameUser: UITextField!
    @IBOutlet weak var txtFieldNameUserArtístico: UITextField!
    @IBOutlet weak var txtFieldNameUserBio: UITextField!
    
    var imagePicker:UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewSetup()
        databaseRef = Database.database().reference()
        storageRef = Storage.storage().reference()
        loadProfileData()
        
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        imgProfile.isUserInteractionEnabled = true
        imgProfile.addGestureRecognizer(imageTap)
        imgProfile.layer.cornerRadius = imgProfile.bounds.height / 3
        imgProfile.clipsToBounds = true
        btnEditImg.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationDissmis()
        setupNavigationShare()
    }
    
    func loadProfileData(){
        if let userID = Auth.auth().currentUser?.uid{
            databaseRef.child("users/profile/").child(userID).observe(.value) { (snapshot) in
                if let values = snapshot.value as? NSDictionary{
                    if let profileImageUrl = values["photoUrl"] as? String{
                        self.imgProfile.sd_setImage(with: URL(string: profileImageUrl))
                    }
                    self.txtFieldNameUser.text = values["username"] as? String
                    self.txtFieldNameUserArtístico.text = values["artist"] as? String
                    self.txtFieldNameUserBio.text = values["bio"] as? String
                }
                
                
            }
        }
        
    }
    @objc func openImagePicker(_ sender:Any){
           //Open image Picker
           self.present(imagePicker, animated: true, completion: nil)
       }
    func setupNavigationDissmis(){
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        //title = presenter.getTitle()
        let back = UIBarButtonItem(image: UIImage(named: "img_back"), style: .plain, target: self, action: #selector(didTapBackButton))
        self.navigationItem.setLeftBarButton(back, animated: false)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    func setupNavigationShare(){
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        //title = presenter.getTitle()
        let back = UIBarButtonItem(image: UIImage(named: "img_retry"), style: .plain, target: self, action: #selector(didTapCheck))
        self.navigationItem.setRightBarButton(back, animated: false)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    @objc func didTapBackButton(){
        presenter.goToPreviousView()
    }
    
    @objc func didTapCheck(){
//        presenter.goToShareView()
        updateUserProfile()
        
    }
    func updateUserProfile(){
        if let userID = Auth.auth().currentUser?.uid{
            let storageItem = storageRef.child("image/jpg").child(userID)
            guard let image = imgProfile.image else {return}
            
            if let newImage  = image.jpegData(compressionQuality: 0.75){
                storageItem.putData(newImage, metadata: nil,completion:  { (metadata, error) in
                    if  error != nil{
                        print(error!)
                        return
                    }
                    storageItem.downloadURL (completion: { (url, error) in
                        if error != nil {
                            print(error!)
                            return
                        }
                        if let profilePhotoUrl = url?.absoluteString{
                            guard let newUserName = self.txtFieldNameUser.text else {return}
                            guard let newBioText = self.txtFieldNameUserBio.text else {return}
                            guard let newUserArt = self.txtFieldNameUserArtístico.text else {return}
                            
                            let newValuesForProfile = ["photoUrl":profilePhotoUrl,"username":newUserName,"artist":newUserArt,"bio":newBioText]
                            
                            self.databaseRef.child("users/profile").child(userID).updateChildValues(newValuesForProfile) { (error, ref) in
                                if error != nil {
                                    print(error!)
                                    return
                                }
                                print("Profile Successfully Update")
                            }
                        }
                    })
                })
            }
            
        }
    }
    private func initViewSetup(){
        configurator.configure(viewController: self)
        
    }
   
    
}

extension ProfileDetailEditViewController:ProfileDetailEditViewControllerProtocol{
    func cleanData() {
        txtFieldNameUser.placeholder = "Hello Wordr"
    }
}

extension ProfileDetailEditViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickImage = info[.originalImage]  as? UIImage{
            self.imgProfile.image = pickImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
