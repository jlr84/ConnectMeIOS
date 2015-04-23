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
    let getdatatype = "Companies"
    var myTagArray = [String]()
    let textCellIdentifier = "tagCell"
    var profileList = [Profile]()
    var TagOwner = "Apple"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("Verifying User...")
        verifyUser()
        println("clearing tag list...")
        clearTagList()
        
        // getTagList()
        
        // initialSetup()
        
        downloadConnectMeData()
        println("ConnectMeData Downloaded")
        for item in self.myTagArray {
            println("Downloaded tags... \(item)")
        }
        
        //getTagList()
        
        //tagTableView2.dataSource = self.myTagArray
        tagTableView2.dataSource = self
        
        //getTagList()
        
        // FOR NEW TABLE VIEW DATA SOURCE
       // tableView.delegate = self
       // tableView.dataSource = self
        
    }
    
    func verifyUser() {
        let fetchRequest = NSFetchRequest(entityName: "Profile")
        
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Profile] {
            profileList = fetchResults
        }
        
        let CurrentUser = profileList[0].userName
        println("Current User is... \(CurrentUser)")
        
        TagOwner = profileList[0].title!
        println("Current Tag Owner is ... \(CurrentUser)")

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
    
    func clearTagList() {
        var tempTagList = [Tags]()
        
        let fetchRequest = NSFetchRequest(entityName: "Tags")
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Tags] {
            tempTagList = fetchResults
        }

        for thisTag in tempTagList {
            managedObjectContext?.deleteObject(thisTag)
        }
    }
    
    
    func deleteAppleTags() {
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
        
        // Delete previous Apple tags
        for Tags in tagList {
            // Delete it from the managedObjectContext
            managedObjectContext?.deleteObject(Tags)
        }
    }
    
    func getTagList() {
        let fetchRequest = NSFetchRequest(entityName: "Tags")
        
        // Sort by title
        let sortDescriptor = NSSortDescriptor(key: "tagName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Predicate for filtering
        let predicate = NSPredicate(format: "tagCompany == %@", TagOwner)
        fetchRequest.predicate = predicate
        
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Tags] {
            tagList = fetchResults
        }
        
    }
    
    func downloadConnectMeData() {
        
        DataManager.getDataWithSuccess( getdatatype ) { (data) -> Void in
            
            // Insert comment here
            let json = JSON(data: data)
            //if let companyName = json[0]["name"].string {
            //    println("SwiftyJSON: \(companyName)")
            //    println("Company Count: \(json.count)")
                
                for num in 0 ... json.count{
                    if let sname = json[num]["name"].string {
                        println(sname)
                        
                        if sname == self.TagOwner {
                            for num2 in 0 ... json[num]["tags"].count {
                                if let tag = json[num]["tags"][num2].string {
                                    let tagnumber = num2 + 1
                                    println("Tag #\(tagnumber) for \(sname) is \(tag)")
                                    self.myTagArray.append(tag)
                                    println("Total Tag Count is... \(self.myTagArray.count)")
                                }
                            }
                        }
                        
                    }
                
            }
            
            println("Done Parsing...Tag List is: ")
            //self.deleteAppleTags()
            if self.myTagArray.count > 0 {
            for num3 in 0 ... self.myTagArray.count - 1 {
                println(self.myTagArray[num3])
                self.saveNewTag(self.myTagArray[num3])
                self.tagTableView2.delegate = self
                self.tagTableView2.dataSource = self
                }
            }
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
        var newTagItem = Tags.createInManagedObjectContext(self.managedObjectContext!, name: title, description: "", website: "https://www.apple.com/jobs/us/students.html", company: TagOwner)
        
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
    
    // MARK: NEW TABLE DATA SOURCE
    // Note, data is in myTagArray
    // Note, text cell identifier is "tagCell"
    // first, set in viewDidLoad...
  /*  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int ) -> Int {
        return myTagArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath ) as UITableViewCell
        
        let row = indexPath.row
        cell.textLabel?.text = myTagArray[row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        println(myTagArray[row])
        
    }
  */
    
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
        
        // Refresh the table view
        self.getTagList()
        
        // tell the table view to animate out that row
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        save()
        
    }/* else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    } */
    }
    @IBAction func ViewResumeSelected (sender:AnyObject) {
        //if ( searchTagList.count >= 1 ) {
            println("Viewing Resume...")
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
