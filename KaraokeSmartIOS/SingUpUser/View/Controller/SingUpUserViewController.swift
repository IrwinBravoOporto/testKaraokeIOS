//
//  LoginUserViewController.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/10/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

protocol SingUpUserViewControllerProtocol:class {
    func cleanData()
}

class SingUpUserViewController: UIViewController{
    
    var presenter: SingUpUserPresenterProtocol!
    let configurator = SingUpUserConfigurator()
    
    var dataBaseRef :DatabaseReference!
    
    @IBOutlet weak var textFieldUserName: UITextField!
    @IBOutlet weak var textFieldUserEmail: UITextField!
    @IBOutlet weak var textFieldPasswordUser: UITextField!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var btnChangeImg: UIButton!
    @IBOutlet weak var buttonSingUp: UIButton!
    
    
    var imagePicker:UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        dataBaseRef = Database.database().reference()
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        imgProfile.isUserInteractionEnabled = true
        imgProfile.addGestureRecognizer(imageTap)
        imgProfile.layer.cornerRadius = imgProfile.bounds.height / 3
        imgProfile.clipsToBounds = true
        btnChangeImg.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
        
        
        textFieldUserName.delegate = self
        textFieldUserEmail.delegate = self
        textFieldPasswordUser.delegate = self
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
    }
    
    override func viewWillAppear(_ animated:Bool){
        super.viewWillAppear(animated)
        textFieldUserName.becomeFirstResponder()
        setupNavigation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        textFieldUserName.resignFirstResponder()
        textFieldUserEmail.resignFirstResponder()
        textFieldPasswordUser.resignFirstResponder()
        
        NotificationCenter.default.removeObserver(self)
        
    }
    
    @objc func openImagePicker(_ sender:Any){
        //Open image Picker
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func singUp(email:String,password:String,name:String,image:UIImage){
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error == nil && user != nil {
                print("User created")
                
                //              1.  Fire Storage
                self.uploadProfileImage(image){ url in
                    
                    if url != nil {
                        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                        changeRequest?.displayName = name
                        changeRequest?.photoURL = url
                        changeRequest?.commitChanges { (error) in
                            if error == nil {
                                print("User display name changed!")
                                self.saveProfile(username: name, profileImageUrl: url!){
                                    success in
                                    if success{
                                        self.dismiss(animated: true, completion: nil)
                                       
                                    }
                                }
                            }else{
                                print("Error: \(error!.localizedDescription)")
                            }
                        }
                    }else{
                        //Error unable to upload profile image
                    }
                    
                }
        
            }else {
                print("Error creating User: \(error?.localizedDescription ?? "")")
            }
             self.presenter.goToProfileUser()
        }
    }
    
    func uploadProfileImage(_ image:UIImage,completion: @escaping ((_ url:URL?)->())){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let storaRef = Storage.storage().reference().child("user /\(uid)")
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {return}
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        storaRef.putData(imageData, metadata: metaData) { metaData,error in
            
            if error != nil , metaData != nil {
                print(error!)
                return
            }
            storaRef.downloadURL { (url, error) in
                if error != nil{
                    print(error!.localizedDescription)
                    return
                }
                
                if let url = url {
                    completion(url)
                }else{
                    completion(nil)
                }
            }
            
            
        }
    }
    
    func saveProfile(username:String,profileImageUrl:URL,completion: @escaping ((_ success:Bool)->())){
        guard let uid = Auth.auth().currentUser?.uid else {return}

        let dataBaseRef = Database.database().reference().child("users/profile/\(uid)")
        
        let userObject = ["username":username,"photoUrl":profileImageUrl.absoluteString] as[String:Any]
        
        dataBaseRef.setValue(userObject){
            error, ref  in
            completion(error == nil)
        }
        
    }
    @IBAction func didTapSingUpLogin(_ sender: UIButton) {
        guard let username = textFieldUserName.text else {return}
        guard let Image = imgProfile.image else {return}
        guard let email = textFieldUserEmail.text else {return}
        guard let password = textFieldPasswordUser.text else {return}
        singUp(email: email,password: password, name: username, image: Image)
    }
    
    @IBAction func didTapChangeImg(_ sender: UIButton) {
        
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
    @objc func didTapBackButton(){
        presenter.goToPreviousView()
    }
    
    
    private func setupView(){
        configurator.configure(viewController: self)
    }
}


extension SingUpUserViewController:SingUpUserViewControllerProtocol{
    func cleanData() {
        textFieldUserEmail.placeholder = "ERGR"
    }
}


extension SingUpUserViewController:UIImagePickerControllerDelegate{
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

extension SingUpUserViewController:UITextFieldDelegate,UINavigationControllerDelegate{
    
    
    
    
}
