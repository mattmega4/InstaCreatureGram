//
//  ElementalCreatorViewController.swift
//  InstaCreatureGram
//
//  Created by Matthew Howes Singleton on 2/4/16.
//  Copyright © 2016 Matthew Howes Singleton. All rights reserved.
//

import UIKit

class ElementalCreatorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var imageViewOne: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var imagePicker: UIImagePickerController!

    var storedOffsets = [Int: CGFloat]()
    
    let filter = CIFilter(name: "CISepiaTone")
    let context = CIContext(options: nil)
    var extent: CGRect!
    var scaleFactor: CGFloat!
    
    var topArr: [UIImage]!
    
//    let model: [[UIImage]] = generateRandomData()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        topArr = [
            UIImage(named: "top1.png")!,
            UIImage(named: "top1.png")!,
            UIImage(named: "top1.png")!,
            UIImage(named: "top1.png")!,
            UIImage(named: "top1.png")!,
            UIImage(named: "top2.png")!,
            UIImage(named: "top3.png")!,
            UIImage(named: "top4.png")!,
            UIImage(named: "top5.png")!,
            UIImage(named: "top6.png")!,
            UIImage(named: "top7.png")!,
            UIImage(named: "top8.png")!,
            UIImage(named: "top9.png")!,
            UIImage(named: "top10.png")!
        ]
        
        //IMAGE FILTER FUNCTIONALITY
        //        scaleFactor = UIScreen.mainScreen().scale
        //        extent = CGRectApplyAffineTransform(UIScreen.mainScreen().bounds, CGAffineTransformMakeScale(scaleFactor, scaleFactor))
        //
        ////        let ciImage = CIImage(image: imageView.image!)
        //
        //        filter?.setDefaults()
        ////        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        //
        //        imageView.image = UIImage(CGImage: context.createCGImage((filter?.outputImage)!, fromRect: extent))
    }
    
    //SCREENSHOT FUNCTIONALITY
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
    
    @IBAction func takePhoto(sender: UIBarButtonItem) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return self.topArr.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("CellT",
                forIndexPath: indexPath)
            
            return cell
    }
    
    func tableView(tableView: UITableView,
        willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath) {
            
            guard let tableViewCell = cell as? TableViewCell else { return }
            
            tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
            tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
    func tableView(tableView: UITableView,
        didEndDisplayingCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath) {
            
            guard let tableViewCell = cell as? TableViewCell else { return }
            
            storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
    

    
}
