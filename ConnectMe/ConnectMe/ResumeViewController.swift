//
//  ResumeViewController.swift
//  ConnectMe
//
//  Created by James Roberts on 3/26/15.
//  Copyright (c) 2015 ConsciousTech. All rights reserved.
//

import CoreData
import UIKit

class ResumeViewController: UIViewController {
    
    var resumeSelected : String?
    
    @IBOutlet weak var resumeWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Load Sample PDF
        //var url = NSURL(string: "http://www.prism.gatech.edu/~jroberts302/ConnectMe/docs/functionalSampleResume.pdf")
        var url = NSURL(string: "https://www.dropbox.com/s/kg0yu2p5m15xtb3/Roberts_Resume_Sample.pdf?dl=0")
        var request = NSURLRequest(URL: url!)
        resumeWebView.loadRequest(request)
        println("Resume Loaded")

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
