//
//  LoginViewController.swift
//  HealthyHarvest
//
//  Created by vanya rohatgi on 2/14/18.
//  Copyright © 2018 Emily Chin. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseAuthUI
import FirebaseDatabase

typealias FIRUser = FirebaseAuth.User

class LoginViewController: UIViewController{
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 6
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        guard let authUI = FUIAuth.defaultAuthUI()
            else { return }
        
        authUI.delegate = self
    
        let authViewController = authUI.authViewController()
        authViewController.isNavigationBarHidden = false
        present(authViewController, animated: true)
    }
}

extension LoginViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
        if let error = error {
            print(error)
            return
//            assertionFailure("Error signing in: \(error.localizedDescription)")
//            return
        }
        
        guard let user = user
            else { return }
        
        let userRef = Database.database().reference().child("users").child(user.uid)
        
        userRef.observeSingleEvent(of: .value, with: { [unowned self] (snapshot) in
            if let user = User(snapshot: snapshot) {
                User.setCurrent(user)
                
                let storyboard = UIStoryboard(name: "Main", bundle: .main)
                if let initialViewController = storyboard.instantiateInitialViewController() {
                    self.view.window?.rootViewController = initialViewController
                    self.view.window?.makeKeyAndVisible()
                }
            } else {
                self.performSegue(withIdentifier: Constants.Segue.toCreateUsername, sender: self)
            }
        })
        print ("handle user signup / login")
        
        UserService.show(forUID: user.uid) { (user) in
            if let user = user {
                // handle existing user
                User.setCurrent(user, writeToUserDefaults: true)
//                let initialViewController = UIStoryboard.initialViewController(for: .main)
//                self.view.window?.rootViewController = initialViewController
//                self.view.window?.makeKeyAndVisible()
            }
        }
    }
}

