//
//  SendResumeViewController.swift
//  ConnectMe
//
//  Created by James Roberts on 3/26/15.
//  Copyright (c) 2015 ConsciousTech. All rights reserved.
//

import UIKit
import CoreData

class SendResumeViewController: UIViewController {
    
    var submitted: Bool = false
    
    @IBOutlet weak var tagTextField: UITextField!
    
    // Retrieve Managed Contect from AppDelegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
    //empty array of tags
    var tagList = [Tags]()
    var searchTagList = [Tags]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
        
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
                
            }
            
        }
    }
 
    func getTagList() {
        let fetchRequest = NSFetchRequest(entityName: "Tags")
        
        // Sort by title
        let sortDescriptor = NSSortDescriptor(key: "tagName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Tags] {
            tagList = fetchResults
        }
    }

    func SearchForTag() {
        
        // get tag from input box
        let submittedTag = tagTextField.text
        println(submittedTag)
        
        let fetchRequest = NSFetchRequest(entityName: "Tags")
        
        // Sort by title
        let sortDescriptor = NSSortDescriptor(key: "tagName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Predicate for filtering
        let predicate = NSPredicate(format: "tagName == %@", submittedTag)
        fetchRequest.predicate = predicate
        
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Tags] {
            searchTagList = fetchResults
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 /*   @IBAction func ManageButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("ShowManageProfileSegue", sender: self)
    }*/
    
    @IBAction func ViewCompanyInfoButtonSelected (sender: AnyObject) {
        
        SearchForTag()
        
        if ( searchTagList.count >= 1 ) {
            println("Tag Found - View Only")
            submitted = false
            //var alertView = UIAlertView()
            //alertView.title = "RESUME SUBMITTED"
            //var alertMessage = "Your default resume was successfully submitted to "
            //alertMessage += searchTagList[0].tagName
            //alertMessage += "!!"
            //alertView.message = alertMessage
            //alertView.addButtonWithTitle("Close")
            //alertView.show()
            self.performSegueWithIdentifier("ShowCompanySegue", sender: SignedInViewController.self)
        } else {
            println("Tag NOT Found")
            var alertView = UIAlertView()
            alertView.title = "Uh oh..."
            var alertMessage = "It seems as though the Tag '"
            alertMessage += tagTextField.text
            alertMessage += "' was not found. Unable to view company info. Please Try Again."
            alertView.message = alertMessage
            alertView.addButtonWithTitle("Close")
            alertView.show()
        }
    }

    @IBAction func SubmitResumeButtonSelected(sender: AnyObject) {
        
        SearchForTag()
        
        if ( searchTagList.count >= 1 ) {
            println("Tag Found - Resume Submit")
            submitted = true
            var alertView = UIAlertView()
            alertView.title = "RESUME SUBMITTED"
            var alertMessage = "Your default resume was successfully submitted to "
            alertMessage += searchTagList[0].tagName
            alertMessage += "!!"
            alertView.message = alertMessage
            alertView.addButtonWithTitle("Close")
            alertView.show()
            self.performSegueWithIdentifier("ShowCompanySegue", sender: SignedInViewController.self)
        } else {
            println("Tag NOT Found")
            var alertView = UIAlertView()
            alertView.title = "Uh oh..."
            var alertMessage = "It seems as though the Tag '"
            alertMessage += tagTextField.text
            alertMessage += "' was not found. Unable to submit resume. Please Try Again."
            alertView.message = alertMessage
            alertView.addButtonWithTitle("Close")
            alertView.show()
            
        }
     }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        var nextController = segue.destinationViewController as CompanyDetailViewController
        
        if submitted {
            nextController.submittedResume = submitted
            nextController.companySubmittedTo = searchTagList[0].tagCompany
            nextController.companySubmittedToWebsite = searchTagList[0].website
            nextController.companyTagSubmittedTo = searchTagList[0].tagName
        }
        nextController.companySubmittedTo = searchTagList[0].tagCompany
        nextController.companySubmittedToWebsite = searchTagList[0].website
        nextController.companyTagSubmittedTo = searchTagList[0].tagName
    }
    
    @IBAction func VerizonSelected(sender: AnyObject) {
        tagTextField.text = "VerizonGT"
    }
    @IBAction func AppleSelected(sender: AnyObject) {
        tagTextField.text = "Apple@GT"
    }
    @IBAction func AttSelected(sender: AnyObject) {
        tagTextField.text = "ATT@GT"
    }
    @IBAction func GoogleSelected(sender: AnyObject) {
        tagTextField.text = "GoogleGT"
    }
    

}
