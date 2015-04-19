//
//  LoginScreenViewController.swift
//  ConnectMe
//
//  Created by James Roberts on 3/25/15.
//  Copyright (c) 2015 ConsciousTech. All rights reserved.
//

import UIKit

class LoginScreenViewController: UIViewController {

    private var CurrentUserName = "DEMO.USER@gmail.com"
    private let API_KEY : String = "777ylayrxi4pb3"
    private let SECRET_KEY : String = "ScJFq56I7oAN9JO5"
    
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
    
    private func loginSuccessAlert() {
            var alertView = UIAlertView()
            alertView.title = "Login Success"
            var alertMessage = "You are successfully logged in as "
            alertMessage += CurrentUserName
            alertView.message = alertMessage
            alertView.addButtonWithTitle("Close")
            alertView.show()
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        // Show successful login alert window
        loginSuccessAlert()
        
    }
    

}
