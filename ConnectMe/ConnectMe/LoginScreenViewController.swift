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
