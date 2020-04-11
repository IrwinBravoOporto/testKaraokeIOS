//
//  LoginUserViewController.swift
//  KaraokeSmartIOS
//
//  Created by Everis on 4/10/20.
//  Copyright © 2020 IrwinIOS. All rights reserved.
//

import UIKit
import FirebaseAuth
protocol LoginUserViewControllerProtocol:class{
    func cleanData()
}


class LoginUserProfileViewController: UIViewController {
    
    var presenter: LoginUserPresenterProtocol!
    let configurator = LoginUserConfigurator()
    
    @IBOutlet weak var textFieldUser: UITextField!
    @IBOutlet weak var textFieldPasswordUser: UITextField!
    
    @IBOutlet weak var butonLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setupView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigation()

    }
    
//    override func viewDidAppear(_ animated: Bool) {
//       if Auth.auth().currentUser?.uid != nil{
//            presenter.goToProfile()
//        }
//    }
    

    func  setupNavigation(){
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
   
    
    @IBAction func didTapLogin(_ sender: UIButton) {
        login()
    }
    
    @IBAction func didTapSingUp(_ sender: UIButton) {
        presenter.goToSingUp()
    }
    
    
    private func setupView(){
        configurator.configure(viewController: self)
    }
    
    func login(){
        Auth.auth().signIn(withEmail: textFieldUser.text!, password: textFieldPasswordUser.text!) { (user, error) in
            if error != nil{
                print(error!)
                self.resetForm()
            }else {
                self.presenter.goToProfile()
                
            }
        }
    }
    
    func resetForm(){
        let alert = UIAlertController(title: "Error logig in", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        butonLogin.isEnabled = true
        butonLogin.setTitle("Continue", for: .normal)
        
    }
}



extension LoginUserProfileViewController:LoginUserViewControllerProtocol{
    func cleanData(){
        textFieldUser.placeholder = "efef"
    }

}
