//
//  CreateUsernameViewController.swift
//  HealthyHarvest
//
//  Created by vanya rohatgi on 3/3/18.
//  Copyright © 2018 Emily Chin. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateUsernameViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    var errInCreatingUser = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.layer.cornerRadius = 6
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let firUser = Auth.auth().currentUser,
            let username = usernameTextField.text,
            !username.isEmpty else { return }
        
        UserService.create(firUser, username: username) { (user, error) in
            if (error?.characters.count ?? 0) > 0 {
                
                self.errInCreatingUser = true
                
                let alert = UIAlertView()
                alert.title = "Username already taken!"
                alert.message = "Choose another username."
                alert.addButton(withTitle: "Ok")
                alert.show()
                
                return
            }
            
            if user == nil {
                self.errInCreatingUser = true
                
                let alert = UIAlertController(title: "Error creating user", message: "Please try again.", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
                
                self.present(alert, animated: true, completion: nil)
                
                return
            }
            
            User.setCurrent(user!, writeToUserDefaults: true)
            
            
//            let initialViewController = UIStoryboard.initialViewController(for: .main)
//            self.view.window?.rootViewController = initialViewController
//            self.view.window?.makeKeyAndVisible()
 
        }
    }
}
