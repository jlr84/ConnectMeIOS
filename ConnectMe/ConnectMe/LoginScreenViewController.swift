//
//  LoginScreenViewController.swift
//  ConnectMe
//
//  Created by James Roberts on 3/25/15.
//  Copyright (c) 2015 ConsciousTech. All rights reserved.
//

import UIKit
import CoreData

class LoginScreenViewController: UIViewController {

    private var CurrentUserName = "James.Roberts07@gmail.com"
    private var CurrentUserID = "unknown"
    private let API_KEY : String = "777ylayrxi4pb3"
    private let SECRET_KEY : String = "ScJFq56I7oAN9JO5"
    //var myTagArray = [String]()
    
    // Retrieve Managed Contect from AppDelegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
    //empty array of profiles
    var ProfileList = [Profile]()
    //var docList = [ReceivedItems]()

    
    //Sample LinkedIn Request: 
    //https://www.linkedin.com/uas/oauth2/authorization?response_type=code&client_id=123456789&redirect_uri=https%3A%2F%2Fwww.example.com%2Fauth%2Flinkedin&state=987654321&scope=r_basicprofile
    // response_type  always "code" - mandatory
    // client_id   API KEY  - mandatory
    // redirect_uri  must match one of our redirect URL in the Linked in app configuration - mandatory
    // state  a unique string that is hard to guess - mandatory
    // scope  specific permissions requested, defaults to app default - optional
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeUserAccountType(sender: AnyObject) {
        CurrentUserName = "recruiter@apple.com"
        
        var alertView = UIAlertView()
        alertView.title = "Changed to \(CurrentUserName)"
        alertView.addButtonWithTitle("Okay")
        alertView.show()

    }
    
    
    @IBAction func signinSelected(sender: AnyObject) {
        
        // Process login thru LinkedIn
        // TBD - Insert Code Here
        
        // With User Logged In, save their profile data to memory
        println("Beginning Profile Parsing...")
        saveUserInfoToMemory()
        
        
        // Show successful login alert window
        loginSuccessAlert()
    }
    
    private func loginSuccessAlert() {
            var alertView = UIAlertView()
            alertView.title = "Login Success"
            var alertMessage = "You are successfully logged in as "
            alertMessage += CurrentUserName
            alertView.message = alertMessage
            alertView.addButtonWithTitle("Close")
            alertView.show()
    }
    
    func saveUserInfoToMemory() {
        
        let getdatatype = "Users"
        var uID : String?
        var ujobtype : String?
        var utitle : String?
        var uphone : String?
        var ulastn : String?
        var ufirstn : String?
        
        DataManager.getDataWithSuccess( getdatatype ) { (data) -> Void in
            
            let json = JSON(data: data)
            for num in 0 ... json.count{
                if let username = json[num]["email"].string {
                    println(username)
                    // Need to change this to case insensitive later on...
                    if username == self.CurrentUserName {
                        
                        // User Found in List... Save Data to temp variables
                        if let fname = json[num]["firstName"].string {
                            ufirstn = fname
                        }
                        if let lname = json[num]["lastName"].string {
                            ulastn = lname
                        }
                        if let title = json[num]["title"].string {
                            utitle = title
                        }
                        if let phone = json[num]["phoneNumber"].string {
                            uphone = phone
                        }
                        if let job = json[num]["jobSearchType"].string {
                            ujobtype = job
                        }
                        if let userID = json[num]["_id"].string {
                            uID = userID
                            self.CurrentUserID = userID
                        }
                        
                        // Now save to persistent storage
                        if let moc = self.managedObjectContext {
                            
                            // But first, delete what is currently there to avoid duplicates
                            self.clearProfileList()
                            
                            // Then, Store the new data
                            var userProfileList = [
                                ( uID, ujobtype, utitle, uphone, ulastn, ufirstn, username )
                            ]
                            
                            // Loop through, creating items
                            for ( uID, ujobtype, utitle, uphone, ulastn, ufirstn, username ) in userProfileList {
                                
                                // Create individual item
                                Profile.createInManagedObjectContext(moc, userID: uID!, userJob: ujobtype!, userTitle: utitle!, userPhone: uphone!, userLastName: ulastn!, userFirstName: ufirstn!, userName: username )
                            }
                    }
                }
                
            }
            
            println("COMPLETE WITH USER SAVE")
            println("The User is \(self.CurrentUserName)")
            println("The ID is \(self.CurrentUserID)")
        }
    }
    }
    
    
    func clearProfileList() {
        let fetchRequest = NSFetchRequest(entityName: "Profile")
        
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Profile] {
            ProfileList = fetchResults
        }
        
        for Profile in ProfileList {
            // Delete it from the managedObjectContext
            managedObjectContext?.deleteObject(Profile)
        }
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
  override  func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        // Show successful login alert window
        //loginSuccessAlert()
        
        var nextController = segue.destinationViewController as InitialChoiceNavViewController
        
        nextController.username = CurrentUserName
        
    }
    

}
