//
//  LoginViewController.swift
//  Makestagram
//
//  Created by Alexander Niehaus on 7/10/18.
//  Copyright © 2018 Make School. All rights reserved.
//
import UIKit
import FirebaseAuth
import FirebaseUI
import FirebaseDatabase

typealias FIRUSer = FirebaseAuth.User

class LoginViewController: UIViewController{
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let authUI = FUIAuth.defaultAuthUI()
            else { return}
        
        authUI.delegate = self
        
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
    }
    
}

extension LoginViewController: FUIAuthDelegate{
    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUSer?, error: Error?){
        UserService.show(forUID: (user?.uid)!) { (user) in
            if let user = user {
                // handle existing user
                User.setCurrent(user, writeToUserDefaults: true)
                
                let initialViewController = UIStoryboard.initialViewController(for: .main)
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
            } else {
                // handle new user
                self.performSegue(withIdentifier: Constants.segue.toCreateUSername, sender: self)
            }
        }
    }
}

