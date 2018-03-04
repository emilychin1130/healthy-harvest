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

typealias FIRUser = FirebaseAuth.User

class LoginViewController: UIViewController{
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 6
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        // 1
        guard let authUI = FUIAuth.defaultAuthUI()
            else { return }
        
        // 2
        authUI.delegate = self
        
        // 3
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
    }
}

extension LoginViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
        if let error = error {
            print(error)
            return
            //assertionFailure("Error signing in: \(error.localizedDescription)")
            //return
        }

         let userRef = reference().child("users").child(user.uid)
        // 1
        userRef.setValue(["username": "chase"])
        
        userRef.observeSingleEvent(of: .value, with: { [unowned self] (snapshot) in
    if let _ = User(snapshot: snapshot) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)

        if let initialViewController = storyboard.instantiateInitialViewController() {
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
        }
    } else {
        self.performSegue(withIdentifier: "toCreateUsername", sender: self)
    }
})
    }
}
