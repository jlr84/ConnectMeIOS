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

}
