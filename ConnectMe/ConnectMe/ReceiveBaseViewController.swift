//
//  ReceiveBaseViewController.swift
//  ConnectMe
//
//  Created by James Roberts on 3/26/15.
//  Copyright (c) 2015 ConsciousTech. All rights reserved.
//

import UIKit
import CoreData

class ReceiveBaseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var tagTableView2: UITableView!
    
    // Retrieve Managed Contect from AppDelegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
    //empty array of tags
    var tagList = [Tags]()
    //var docList = [ReceivedItems]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
        
        tagTableView2.dataSource = self
        
        getTagList()
        
    }
    
    func initialSetup() {
        getTagList()
        if ( tagList.count >= 1 ) {
            println("No need to load data")
        } else {
        println("need to load data")
            
            if let moc = self.managedObjectContext {
                //Create Dummy data
                var items = [
                    ("Apple@GT", "Recruiting event at GA Tech, Spring 2015", "https://www.apple.com/jobs/us/students.html", "Apple"),
                    ("Apple_UFL15" , "Recruiting event at the University of Florida, Spring 2015", "https://www.apple.com/jobs/us/students.html", "Apple"),
                    ("VerizonGT", "Recruiting event at Ga Tech, Spring 2015", "http://www.verizon.com/about/careers/from-campus-to-career", "Verizon"),
                    ("GoogleGT", "Recruiting event at GA Tech, Spring 2015", "https://www.google.com/about/careers/students/", "Google"),
                    ("ATT@GT", "Recruiting event at GA Tech, Spring 2015", "http://att.jobs/careers/college/", "At&t")
                ]
                
                // Loop through, creating items
                for (tagName, tagDescription, tagWebsite, tagCompany) in items {
                    // Create individual item
                    Tags.createInManagedObjectContext(moc, name: tagName, description: tagDescription, website: tagWebsite, company: tagCompany)
                }
                
                tagTableView2.dataSource = self
            }
            
        }
    }
    
    func getTagList() {
        let fetchRequest = NSFetchRequest(entityName: "Tags")
        
        // Sort by title
        let sortDescriptor = NSSortDescriptor(key: "tagName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Predicate for filtering
        let predicate = NSPredicate(format: "tagCompany == %@", "Apple")
        fetchRequest.predicate = predicate
        
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Tags] {
            tagList = fetchResults
        }
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
  
    @IBAction func addTagSelected(sender: AnyObject) {
        self.addNewTag()
    }
    
    let addTagAlertViewTag = 0
    let addTagTextAlertViewTag = 1
    var newTagDescriptionTextField: UITextField?
    var newTagTextField: UITextField?
    func addNewTag() {
        
        var titlePrompt = UIAlertController(title: "Enter New Name", message: "", preferredStyle: .Alert)
        
   
        titlePrompt.addTextFieldWithConfigurationHandler {
            (textField) -> Void in
            self.newTagTextField = textField
            textField.placeholder = "Tag Name"
        }
        
        titlePrompt.addTextFieldWithConfigurationHandler {
            (textField2) -> Void in
            self.newTagDescriptionTextField = textField2
            textField2.placeholder = "Tag Description"
        }
        
        titlePrompt.addAction(UIAlertAction(title: "Submit",
            style: .Default,
            handler: { (action) -> Void in
                if let textField = self.newTagTextField {
                    self.saveNewTag(textField.text)
                }
        }))
        
        self.presentViewController(titlePrompt,
            animated: true,
            completion: nil)
        
    }
    
    func saveNewTag(title : String) {
        
        // Create the new Tag
        var newTagItem = Tags.createInManagedObjectContext(self.managedObjectContext!, name: title, description: "", website: "", company: "Apple")
        
        // Update the array containing the table view row data
        self.getTagList()
        
        // Animate in the new row
        // Use Swift's find() function to figure out the index of the newLogItem
        // after it's been added and sorted in our logItems array
        if let newTagIndex = find(tagList, newTagItem) {
            // Create an NSIndexPath from the newItemIndex
            let newTagItemIndexPath = NSIndexPath(forRow: newTagIndex, inSection: 0)
            // Animate in the insertion of this row
            tagTableView2.insertRowsAtIndexPaths([ newTagItemIndexPath ], withRowAnimation: .Automatic)
            save()
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return tagList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("tagCell") as UITableViewCell
        
        // Get the tag for this index
        let tagItem = tagList[indexPath.row]
 
        // Set the title of the cell to be the name of tag
        cell.textLabel?.text = tagItem.tagName
        cell.textLabel?.textColor = UIColor(red: 0.21, green: 0.73, blue: 0.96, alpha: 1)
        
    return cell
    }
    

    // Override to support conditional editing of the table view.
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    
    // Override to support editing the table view.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
        //Find the items the user wants to delete
        let tagToDelete = tagList[indexPath.row]
        
        // Delete it from the managedObjectContext
        managedObjectContext?.deleteObject(tagToDelete)
        
        // Refresh teh table view
        self.getTagList()
        
        // tell the table view to animate out that row
        tagTableView2.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        save()
        
    }/* else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    } */
    }
    @IBAction func ViewResumeSelected (sender:AnyObject) {
        //if ( searchTagList.count >= 1 ) {
            println("Viewing Resume...")
          //  submitted = false
            //var alertView = UIAlertView()
            //alertView.title = "RESUME SUBMITTED"
            //var alertMessage = "Your default resume was successfully submitted to "
            //alertMessage += searchTagList[0].tagName
            //alertMessage += "!!"
            //alertView.message = alertMessage
            //alertView.addButtonWithTitle("Close")
            //alertView.show()
        self.performSegueWithIdentifier("ShowResumeSegue", sender: ReceiveBaseViewController.self)
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
    
    
    // MARK: - Navigation
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var nextController = segue.destinationViewController as ResumeViewController
        
        nextController.resumeSelected = "Fix this Resume Name Later"
    }
*/
}
