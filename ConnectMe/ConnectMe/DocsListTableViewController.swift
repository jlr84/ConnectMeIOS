//
//  DocsListTableViewController.swift
//  ConnectMe
//
//  Created by James Roberts on 3/26/15.
//  Copyright (c) 2015 ConsciousTech. All rights reserved.
//

import UIKit
import CoreData

class DocsListTableViewController: UITableViewController, UITableViewDataSource {

    @IBOutlet weak var documentTableView: UITableView!
    
    // Retrieve Managed Contect from AppDelegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
    var docList = [ReceivedItems]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()
         
        documentTableView.dataSource = self
        
        getDocList()
    }
    
    func initialSetup() {
        getDocList()
        if ( docList.count >= 1 ) {
            println("No need to load document data")
        } else {
            println("need to load document data")
            
            if let moc = self.managedObjectContext {
                //Create Dummy data
                var docs = [
                    ("Doe, John", "2015-03-24 13:23"),
                    ("Latheef, Abdul", "2015-03-23 17:45"),
                    ("Donald, Kimberly", "2015-03-23 16:33"),
                    ("Stevens, Vaibav", "2015-03-22 15:37)"),
                    ("Conroy, Pat", "2015-03-22 14:05"),
                    ("Graedon, Kat", "2015-03-22 09:34")
                ]
               
                // Loop through, creating items
                for (person, date) in docs {
                    ReceivedItems.createInManagedObjectContext(moc, senderName: person, itemName: date)
                }
                
                documentTableView.dataSource = self
            }
            
        }
    }
    
    
    func getDocList() {
        let fetchRequest = NSFetchRequest(entityName: "ReceivedItems")
        
        // Sort by title
        let sortDescriptor = NSSortDescriptor(key: "senderName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [ReceivedItems] {
            docList = fetchResults
        }
    }
    
    func save() {
        var error : NSError?
        if(managedObjectContext!.save(&error) ){
            println(error?.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return docList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("docCell") as UITableViewCell
        
        // Get the tag for this index
        let docItem = docList[indexPath.row]
        
        // Set the title of the cell to be the name of tag
        cell.textLabel?.text = docItem.senderName
        cell.textLabel?.textColor = UIColor(red: 0.21, green: 0.73, blue: 0.96, alpha: 1)
        
        return cell
    }
    

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }


    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let docItemToDelete = docList[indexPath.row]
            managedObjectContext?.deleteObject(docItemToDelete)
            self.getDocList()
            documentTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            save()
            
        } /* else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }  */
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
