//
//  listInformationViewController.swift
//  HealthyHarvest
//
//  Created by Emily Chin on 2/13/18.
//  Copyright © 2018 Emily Chin. All rights reserved.
//

import Foundation
import UIKit

class ListInformationViewController: UIViewController {
    
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var descriptTextField: UITextField!

    var item: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //init toolbar
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
        //create left side empty space so that done button set on right side
        let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: Selector("doneButtonAction"))
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        //setting toolbar as inputAccessoryView
        self.itemNameTextField.inputAccessoryView = toolbar
        self.descriptTextField.inputAccessoryView = toolbar
    }
    
    func doneButtonAction() {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "save" {
            let items = CoreDataHelper.retrieveItems()
            var listOfItems = [String]()
            for item in items {
                listOfItems.append(item.item!)
            }
            if (itemNameTextField.text?.isEmpty)! {
                let alert = UIAlertController(title: "", message: "You forgot to add an item!" , preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Add a name", style: UIAlertActionStyle.default, handler: {(action) in alert.dismiss(animated: true, completion: nil) } ) )
                self.present(alert, animated: true, completion: nil)
            } else {
                let item = self.item ?? CoreDataHelper.newItem()
                item.item = itemNameTextField.text ?? ""
                CoreDataHelper.saveItem()
                }
            //do something about empty description..maybe
                    
        } else {
            let item = self.item ?? CoreDataHelper.newItem()
            item.item = itemNameTextField.text ?? ""
            CoreDataHelper.saveItem()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let item = item {
            itemNameTextField.text = item.item
        } else {
            habitNameTextField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.itemNameTextField.resignFirstResponder()
        return true
    }
}
