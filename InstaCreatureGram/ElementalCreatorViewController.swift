//
//  ElementalCreatorViewController.swift
//  InstaCreatureGram
//
//  Created by Matthew Howes Singleton on 2/4/16.
//  Copyright © 2016 Matthew Howes Singleton. All rights reserved.
//

import UIKit

class ElementalCreatorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    
    var imagePicker: UIImagePickerController!
    let filter = CIFilter(name: "CISepiaTone")
    let context = CIContext(options: nil)
    var extent: CGRect!
    var scaleFactor: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scaleFactor = UIScreen.mainScreen().scale
        extent = CGRectApplyAffineTransform(UIScreen.mainScreen().bounds, CGAffineTransformMakeScale(scaleFactor, scaleFactor))
        
        let ciImage = CIImage(image: imageView.image!)
        
        filter?.setDefaults()
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        
        imageView.image = UIImage(CGImage: context.createCGImage((filter?.outputImage)!, fromRect: extent))
    }
    
    //SCREENSHOT FUNCTIONALITY
    //Not yet hooked up to Storyboard button
    @IBAction func screenShot(sender: AnyObject) {
        let image = takeScreenshot()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
    func takeScreenshot() -> UIImage {
        let theView = self.view
        UIGraphicsBeginImageContextWithOptions(theView.bounds.size, true, 0.0)
        theView.drawViewHierarchyInRect(theView.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    //TAKE PHOTO FUNCTIONALITY
    //Not yet hooked up to Storyboard button
    @IBAction func takePhoto(sender: UIButton) {
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
    }

    //IMAGE FILTER FUNCTIONALITY
    //Not yet hooked up to Storyboard
    

}
