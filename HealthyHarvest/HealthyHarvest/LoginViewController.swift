//
//  LoginViewController.swift
//  HealthyHarvest
//
//  Created by vanya rohatgi on 2/14/18.
//  Copyright © 2018 Emily Chin. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController{
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        print("login button tapped!")
    }
}
