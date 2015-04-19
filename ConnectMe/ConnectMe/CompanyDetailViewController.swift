//
//  CompanyDetailViewController.swift
//  ConnectMe
//
//  Created by James Roberts on 3/26/15.
//  Copyright (c) 2015 ConsciousTech. All rights reserved.
//

import UIKit

class CompanyDetailViewController: UIViewController {
    
    @IBOutlet weak var submittedNameBlock: UITextField!
    var submittedResume: Bool? = false
    var companySubmittedTo: String?
    var companySubmittedToWebsite: String?
    var companyTagSubmittedTo: String?
    
    @IBOutlet weak var webView: UIWebView!
    
    func popToRoot(sender:UIBarButtonItem){
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        // if resume was submitted, hide default back button and create new one going to root controller
        if (submittedResume! == true) {
            self.navigationItem.setHidesBackButton(true, animated: false)
            
            //navigationController.setNavigationBarHidden(false, animated:true)
            var myBackButton:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
            myBackButton.addTarget(self, action: "popToRoot:", forControlEvents: UIControlEvents.TouchUpInside)
            myBackButton.setTitle("Home", forState: UIControlState.Normal)
            myBackButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
            myBackButton.sizeToFit()
            
            var myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: myBackButton)
            
            self.navigationItem.leftBarButtonItem  = myCustomBackButtonItem
        }
        
            //Setup Company Name Block
            var blockName : String = ""
            blockName += companySubmittedTo!
            blockName += "  / Tag: '"
            blockName += companyTagSubmittedTo!
            blockName += "'"
            submittedNameBlock.text = blockName
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var url = NSURL(string: companySubmittedToWebsite!)
        var request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
        println(submittedResume)
        println(companySubmittedToWebsite)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation
    
    override func viewWillDisappear(animated: Bool) {
        
        // if resume was submitted, return to root view screen
        if (submittedResume! == true) {
            navigationController?.popToRootViewControllerAnimated(false)
        }
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
