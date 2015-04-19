//
//  ReceivedItems.swift
//  ConnectMe
//
//  Created by James Roberts on 3/24/15.
//  Copyright (c) 2015 ConsciousTech. All rights reserved.
//

import Foundation
import CoreData

class ReceivedItems: NSManagedObject {

    @NSManaged var dateReceived: NSDate
    @NSManaged var itemName: String
    @NSManaged var senderName: String


class func createInManagedObjectContext(moc: NSManagedObjectContext, senderName: String, itemName: String) -> ReceivedItems {
    let newDoc = NSEntityDescription.insertNewObjectForEntityForName("ReceivedItems", inManagedObjectContext: moc) as ReceivedItems
    newDoc.itemName = itemName
    newDoc.senderName = senderName
    newDoc.dateReceived = NSDate()
    
    return newDoc
}
}
