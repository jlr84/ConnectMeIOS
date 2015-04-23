//
//  ManageProfileViewController.swift
//  ConnectMe
//
//  Created by James Roberts on 3/26/15.
//  Copyright (c) 2015 ConsciousTech. All rights reserved.
//

import UIKit
import CoreData

class ManageProfileViewController: UIViewController {

    // Retrieve Managed Contect from AppDelegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
    @IBOutlet weak var profiletitle: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var middlename: UITextField!
    @IBOutlet weak var lastname: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        //Create new fetch request
        let fetchRequest = NSFetchRequest(entityName: "Profile")
        
        // Execute fetch request
        if let fetchResults  = managedObjectContext?.executeFetchRequest(fetchRequest, error: nil) as? [Profile] {
            
            // Create an Alert and set it's message to whatever userName is
            var alertView = UIAlertView()
            var alertMessage = ""
            alertMessage += fetchResults[0].firstName!
            alertMessage += ", Click to Edit your profile."
            alertView.message = alertMessage
            alertView.addButtonWithTitle("Continue")
            //Display the alert
            
            alertView.show()
            //self.presentViewController(alert, animated: true, completion: nil)
            
            firstname.text! = fetchResults[0].firstName!
            lastname.text! = fetchResults[0].lastName!
            middlename.text! = fetchResults[0].middleInitial!
            phone.text! = fetchResults[0].phone!
            email.text! = fetchResults[0].email!
            profiletitle.text! = fetchResults[0].title!
        }
        
        
        
        
        
        
       /* let newProfile = NSEntityDescription.insertNewObjectForEntityForName("Profile", inManagedObjectContext: self.managedObjectContext!) as Profile
        
        newProfile.company = "No Company"
        newProfile.email = "abdul.latheef@gatech.edu"
        newProfile.firstName = "Abdul"
        newProfile.lastName = "Latheef"
        newProfile.middleInitial = "L"
        newProfile.phone = "360-555-1234"
        newProfile.title = "Student"
        newProfile.userName = "abdul.latheef@gatech.edu"
*/
        // Do any additional setup after loading the view.
        
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 /*
    override func viewWillDisappear(animated: Bool) {
        save()
    }
    
    func save() {
        var error : NSError?
        if(managedObjectContext!.save(&error) ){
            println(error?.localizedDescription)
        }
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
