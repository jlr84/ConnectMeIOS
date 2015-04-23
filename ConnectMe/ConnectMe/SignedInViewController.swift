//
//  SignedInViewController.swift
//  ConnectMe
//
//  Created by James Roberts on 3/25/15.
//  Copyright (c) 2015 ConsciousTech. All rights reserved.
//

import UIKit

class SignedInViewController: UIViewController {

    var myTagArray = [String]()
    var currentusername : String?
    let getdatatype = "Companies"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Dispaly current user
        if currentusername == nil {
            println("Data transfer FAILED")
            println(currentusername)
        } else {
        println("Current Username is \(currentusername)")
        }
        
        // Download ConnectMe Data
        downloadConnectMeData()
        
    }
    
    func downloadConnectMeData() {
        
        DataManager.getDataWithSuccess( getdatatype ) { (data) -> Void in
            
            // Insert comment here
            let json = JSON(data: data)
            if let companyName = json[0]["name"].string {
                println("SwiftyJSON: \(companyName)")
                println("Company Count: \(json.count)")
                
                for num in 0 ... json.count{
                    if let sname = json[num]["name"].string {
                        println(sname)
                        
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
            for num3 in 0 ... self.myTagArray.count - 1 {
                println(self.myTagArray[num3])
            }
        }
        
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
