//
//  InitialChoiceNavViewController.swift
//  ConnectMe
//
//  Created by James Roberts on 3/26/15.
//  Copyright (c) 2015 ConsciousTech. All rights reserved.
//

import UIKit

class InitialChoiceNavViewController: UINavigationController {
    
    var username : String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //println(username)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        var nextController = segue.destinationViewController as SignedInViewController
        
        nextController.currentusername = username
        
    }
    

}
