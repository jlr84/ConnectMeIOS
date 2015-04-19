//
//  SignedInViewController.swift
//  ConnectMe
//
//  Created by James Roberts on 3/25/15.
//  Copyright (c) 2015 ConsciousTech. All rights reserved.
//

import UIKit

class SignedInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LogOutButtonPressed(sender: AnyObject) {
        //self.navigationController?.popViewControllerAnimated(true)
        //performSegueWithIdentifier("showContactDetail", sender: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
