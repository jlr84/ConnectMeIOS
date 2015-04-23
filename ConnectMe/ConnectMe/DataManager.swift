//
//  DataManager.swift
//
//  Created by James Roberts on 4/23/15.
//  Copyright (c) 2015 ConsciousTech. All rights reserved.
//
//  This file is greatly changed from the original training
//     filed by  Ray Wenderlich
//  Original File Created by Dani Arnaout on 9/2/14.
//  Edited by Eric Cerney on 9/27/14.
//  Copyright (c) 2014 Ray Wenderlich All rights reserved.
//

import Foundation

var currentURL = ""
let allCompaniesURL = "http://128.61.104.114:18081/api/companies/"
let allUsersURL = "http://128.61.104.114:18081/api/users/"

class DataManager {
  
    class func getDataWithSuccess( type : String, success: ((myDownloadData: NSData!) -> Void)) {
        
        //Select URL based on type
        if type == "Companies" {
            currentURL = allCompaniesURL
        } else if type == "Users" {
            currentURL = allUsersURL
        }
        
        
        //1
        loadDataFromURL(NSURL(string: currentURL)!, completion:{(data, error) -> Void in
            //2
            if let urlData = data {
                //3
                success(myDownloadData: urlData)
            }
        })
    }
    
    
  class func getDataFromFileWithSuccess(success: ((data: NSData) -> Void)) {
    //1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
      //2
      let filePath = NSBundle.mainBundle().pathForResource("Companies",ofType:"json")
   
      var readError:NSError?
      if let data = NSData(contentsOfFile:filePath!,
        options: NSDataReadingOptions.DataReadingUncached,
        error:&readError) {
        success(data: data)
      }
    })
  }
  
  class func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSError?) -> Void) {
    var session = NSURLSession.sharedSession()
    
    // Use NSURLSession to get data from an NSURL
    let loadDataTask = session.dataTaskWithURL(url, completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
      if let responseError = error {
        completion(data: nil, error: responseError)
      } else if let httpResponse = response as? NSHTTPURLResponse {
        if httpResponse.statusCode != 200 {
          var statusError = NSError(domain:"com.raywenderlich", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
          completion(data: nil, error: statusError)
        } else {
          completion(data: data, error: nil)
        }
      }
    })
    
    loadDataTask.resume()
  }
}