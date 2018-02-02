//
//  CoreDateHelper.swift
//  HealthyHarvest
//
//  Created by Emily Chin on 2/2/18.
//  Copyright © 2018 Emily Chin. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import UserNotifications

class CoreDataHelper {
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let persistentContainer = appDelegate.persistentContainer
    static let managedContext = persistentContainer.viewContext
    
    static func newItem() -> Item {
        let item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: managedContext) as! Item
        return item
    }
    
    static func saveItem() {
        do {
            try managedContext.save()
        } catch let error as NSError {
        }
    }
    
    static func delete(item: Item) {
        managedContext.delete(item)
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [item.item!])
        saveItem()
    }
    
    static func retrieveItems() -> [Item] {
        let fetchRequest = NSFetchRequest<Item>(entityName: "Item")
        do {
            let results = try managedContext.fetch(fetchRequest)
            return results
        } catch let error as NSError {
        }
        return []
    }
}
