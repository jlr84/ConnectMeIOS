//
//  SentItems.swift
//  ConnectMe
//
//  Created by James Roberts on 3/24/15.
//  Copyright (c) 2015 ConsciousTech. All rights reserved.
//

import Foundation
import CoreData

class SentItems: NSManagedObject {

    @NSManaged var dateSent: NSDate
    @NSManaged var recipientName: String

}
