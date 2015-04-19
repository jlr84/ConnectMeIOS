//
//  Tags.swift
//  ConnectMe
//
//  Created by James Roberts on 3/24/15.
//  Copyright (c) 2015 ConsciousTech. All rights reserved.
//

import Foundation
import CoreData

class Tags: NSManagedObject {

    @NSManaged var tagName: String
    @NSManaged var tagDescription: String?
    @NSManaged var dateStart: NSDate?
    @NSManaged var dateEnd: NSDate?
    @NSManaged var active: NSNumber?
    @NSManaged var website: String?
    @NSManaged var tagCompany: String?
    
    class func createInManagedObjectContext(moc: NSManagedObjectContext, name: String, description: String, website: String, company: String) -> Tags {
        let newTag = NSEntityDescription.insertNewObjectForEntityForName("Tags", inManagedObjectContext: moc) as Tags
        newTag.tagName = name
        newTag.tagDescription = description
        newTag.active = true
        newTag.dateStart = NSDate()
        newTag.dateEnd = NSDate()
        newTag.website = website
        newTag.tagCompany = company
        
        return newTag
    }

}
