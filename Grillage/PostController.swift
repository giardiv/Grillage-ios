//
//  PostController.swift
//  Grillage
//
//  Created by Vincent on 26/06/2016.
//  Copyright © 2016 Vincent. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PostController: UIViewController,UITextViewDelegate {
    @IBOutlet weak var padlockText: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    let sharedData = ShareData.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        padlockText.layer.cornerRadius = 5
        padlockText.layer.borderColor = UIColor.lightGrayColor().CGColor
        padlockText.layer.borderWidth = 1
        padlockText.textColor = UIColor.lightGrayColor()
        
        padlockText.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == UIColor.lightGrayColor() {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
    }
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "What's up here ?"
            textView.textColor = UIColor.lightGrayColor()
        }
    }
    @IBAction func sendMessage(sender: UIButton) {
        let loc = ["lon": self.sharedData.lon,"lat": self.sharedData.lat]
        let user = UIDevice.currentDevice().identifierForVendor!.UUIDString
        let username = user
        print(user)
        let text = padlockText.text
        Alamofire.request(.GET, "http://giardi.fr/grillage/web/app_dev.php/add/padlock",parameters: ["loc": loc, "type" : "text", "user" : username, "message" : text])
            .responseString { response in
                let data = response.result.value as String?
                if let dataFromString = data?                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 .dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false){
                    let json = JSON(data: dataFromString)
                    //newUserName = json["data"].stringValue
                    
                    print(json["data"])
                    if(json["ok"]){
                        for padlock in json["data"]{
                            print(padlock.1["lon"])
                            //ViewController.addMark(padlock.1)
                        }
                    }
                }
        }
    }
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
