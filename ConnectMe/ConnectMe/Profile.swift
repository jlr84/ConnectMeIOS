//
//  Profile.swift
//  ConnectMe
//
//  Created by James Roberts on 3/24/15.
//  Copyright (c) 2015 ConsciousTech. All rights reserved.
//

import Foundation
import CoreData

class Profile: NSManagedObject {

    @NSManaged var userName: String?
    @NSManaged var firstName: String?
    @NSManaged var middleInitial: String?
    @NSManaged var lastName: String?
    @NSManaged var phone: String?
    @NSManaged var email: String?
    @NSManaged var title: String?
    @NSManaged var company: String?
    @NSManaged var userID: String?
    @NSManaged var jobSearchType: String?

    class func createInManagedObjectContext(moc: NSManagedObjectContext, userID: String, userJob: String, userTitle: String, userPhone: String, userLastName: String, userFirstName: String, userName: String ) -> Profile {
        
        let newProfile = NSEntityDescription.insertNewObjectForEntityForName("Profile", inManagedObjectContext: moc) as Profile
        
        newProfile.userID = userID
        newProfile.jobSearchType = userJob
        newProfile.title = userTitle
        newProfile.phone = userPhone
        newProfile.lastName = userLastName
        newProfile.firstName = userFirstName
        newProfile.userName = userName
        // Not Used --
        newProfile.middleInitial = ""
        newProfile.email = userName
        newProfile.company = userJob
        
        return newProfile
    }
    
}
