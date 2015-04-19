//
//  Resume.swift
//  ConnectMe
//
//  Created by James Roberts on 3/24/15.
//  Copyright (c) 2015 ConsciousTech. All rights reserved.
//

import Foundation
import CoreData

class Resume: NSManagedObject {

    @NSManaged var resumeTitle: String
    @NSManaged var resumeDescription: String
    @NSManaged var resumePath: String

}
