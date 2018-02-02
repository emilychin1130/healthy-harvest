//
//  ListViewController.swift
//  HealthyHarvest
//
//  Created by Emily Chin on 2/2/18.
//  Copyright © 2018 Emily Chin. All rights reserved.
//

import Foundation
import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var ListTableView: UITableView!
    
    @IBAction func unwindToListHabitsViewController(_ segue: UIStoryboardSegue) {
        
        self.item = CoreDataHelper.retrieveItems()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = CoreDataHelper.retrieveItems()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}
