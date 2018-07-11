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
        if let error = error{
            assertionFailure("Error signing in: \(error.localizedDescription)")
            return
        }
        print("handle user signup/ login")
    }
}
