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
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func unwindToListHabitsViewController(_ segue: UIStoryboardSegue) {
        
        self.items = CoreDataHelper.retrieveItems()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = CoreDataHelper.retrieveItems()
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    var items = [Item]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    //LIST TABLE VIEW
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataHelper.delete(item: items[indexPath.row])
            items = CoreDataHelper.retrieveItems()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let row = indexPath.row
//        if tableView.isEditing == true {
//            self.performSegue(withIdentifier: "displayHabit", sender: nil)
//        } else {
            let item = items[row]
//            let list = CoreDataHelper.retrieveGeneral()
//            let general = list[0]
            if cell?.accessoryType == .checkmark {
                cell?.accessoryType = .none
//                habit.days -= 1
                item.checked = false
                CoreDataHelper.saveItem()
//                general.points -= (1 + Int(habit.days))
//                if general.points < 0 {
//                    let alert = UIAlertController(title: "Negative Points?", message: "Negative points are displayed when you have used up points that you accidentally received.", preferredStyle: UIAlertControllerStyle.alert)
//                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in alert.dismiss(animated: true, completion: nil) } ) )
//                    self.present(alert, animated: true, completion: nil)
//                }
            } else {
                cell?.accessoryType = .checkmark
//                habit.days += 1
                item.checked = true
                CoreDataHelper.saveItem()
 //               general.points += Int(habit.days)
 //           }
//            self.numberOfPointsLabel.reloadInputViews()
            self.tableView.reloadData()
        }
        CoreDataHelper.saveItem()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableCell") as! ListTableCell
        
        let row = indexPath.row
        
        let item = items[row]
        
        cell.nameOfItem.text = "\(item.item!)"
        
        cell.nameOfDescription.text = "\(item.descript)"
        
        if item.checked == true {
            cell.accessoryType = .checkmark
        } else
        {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    // SEGUE
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "displayItem" {
                
                let indexPath = tableView.indexPathForSelectedRow!
                
                let item = items[indexPath.row]
                
                let listInformationViewController = segue.destination as! ListInformationViewController
                
                listInformationViewController.item = item
                
//            } else if identifier == "addItem" {
//                let list = CoreDataHelper.retrieveGeneral()
//                let general = list[0]
//                if habits.count >= Int(general.rows) {
//                    let alert = UIAlertController(title: "No More Slots", message: "Buy more at the shop or delete some existing habits!", preferredStyle: UIAlertControllerStyle.alert)
//                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in alert.dismiss(animated: true, completion: nil) } ) )
//                    self.present(alert, animated: true, completion: nil)
//                }
            }
        }
    }

    
}
