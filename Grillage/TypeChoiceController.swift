//
//  TypeChoiceController.swift
//  Grillage
//
//  Created by Vincent on 27/06/2016.
//  Copyright © 2016 Vincent. All rights reserved.
//

import UIKit
import Alamofire
import AssetsLibrary

class TypeChoiceController: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    var image = UIImage()
 
    //@IBOutlet weak var imgViewTest: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Yoo yoo")
    }
    @IBAction func openCamera(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        self.image = image
        let imageData = UIImageJPEGRepresentation(self.image, 0.6)
        
        //let imageData = NSData(data:UIImagePNGRepresentation(pickedimage))
        //let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        //var docs: String = paths[0]
        let fullPath = NSTemporaryDirectory().stringByAppendingPathComponent("tes.jpg")
        imageData!.writeToFile(fullPath, atomically: true)

        let path1 = NSURL(string: fullPath)
        
        //let img = UIImage(contentsOfFile: fullPath)
        
        //let data = NSData(contentsOfURL: path1!)!
        //let image2 = UIImage(data: data, scale: UIScreen.mainScreen().scale)!
        
        //imgViewTest.image = image2
        
        //if let resourceUrl = NSBundle.mainBundle().URLForResource("instagram", withExtension: "jpg") {
        //    if NSFileManager.defaultManager().fileExistsAtPath(resourceUrl.path!) {
        //        print("file found")
        //    }
        //}
        
        //print(path1)
        //print(img)
        
        //let compressedJPGImage = UIImage(data: imageData!)
//        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
//        
//        var path1 = NSURL()
//        
//        ALAssetsLibrary().writeImageToSavedPhotosAlbum(image.CGImage,
//                                                       metadata:  nil,
//                                                       completionBlock: { (path:NSURL!, error:NSError!) -> Void in
//                                                        path1 = path
//        })
        
//        let documentDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first as String!
//        let photoURL = NSURL(fileURLWithPath: documentDirectory)
//        print(photoURL)
        
        
        let r = Alamofire.upload(.POST, "http://giardi.fr/grillage/web/app_dev.php/add/padlock", file: path1!)
        print(r)
        
        print("save img")
        self.dismissViewControllerAnimated(true, completion: nil);
    }
}

extension String {
    
    func stringByAppendingPathComponent(path: String) -> String {
        
        let nsSt = self as NSString
        
        return nsSt.stringByAppendingPathComponent(path)
    }
}
