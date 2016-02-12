//
//  ElementalCreatorViewController.swift
//  InstaCreatureGram
//
//  Created by Matthew Howes Singleton on 2/4/16.
//  Copyright © 2016 Matthew Howes Singleton. All rights reserved.
//

import UIKit

class ElementalCreatorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet var finalView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var imageViewOne: UIImageView!
    @IBOutlet weak var imageViewTwo: UIImageView!
    @IBOutlet weak var imageViewThree: UIImageView!
    
    var imagePicker: UIImagePickerController!
    var storedOffsets = [Int: CGFloat]()
    var topArr: [UIImage]!
    var bodArr: [UIImage]!
    var botArr: [UIImage]!
    var newCreature = Creature()
    
//create an array of array
    var combinedArr : [[UIImage]]?

//    combinedArr
    
    var expanded = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageViewOne.userInteractionEnabled = true
        imageViewTwo.userInteractionEnabled = true
        imageViewThree.userInteractionEnabled = true

        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tap:")
        tapGestureRecognizer.numberOfTapsRequired = 2
        
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: "pinch:")
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "pan:")
        panGestureRecognizer.minimumNumberOfTouches = 1
        panGestureRecognizer.maximumNumberOfTouches = 2
        
        let rotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: "rotate:")
        
        
        
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: "tap1:")
        tapGestureRecognizer1.numberOfTapsRequired = 2
        
        let pinchGestureRecognizer1 = UIPinchGestureRecognizer(target: self, action: "pinch1:")
        
        let panGestureRecognizer1 = UIPanGestureRecognizer(target: self, action: "pan1:")
        panGestureRecognizer1.minimumNumberOfTouches = 1
        panGestureRecognizer1.maximumNumberOfTouches = 2
        
        let rotationGestureRecognizer1 = UIRotationGestureRecognizer(target: self, action: "rotate1:")
        
        
        
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: "tap2:")
        tapGestureRecognizer2.numberOfTapsRequired = 2
        
        let pinchGestureRecognizer2 = UIPinchGestureRecognizer(target: self, action: "pinch2:")
        
        let panGestureRecognizer2 = UIPanGestureRecognizer(target: self, action: "pan2:")
        panGestureRecognizer2.minimumNumberOfTouches = 1
        panGestureRecognizer2.maximumNumberOfTouches = 2
        
        let rotationGestureRecognizer2 = UIRotationGestureRecognizer(target: self, action: "rotate2:")
        
        
        imageViewOne.userInteractionEnabled = true
        imageViewOne.addGestureRecognizer(tapGestureRecognizer)
        imageViewOne.addGestureRecognizer(pinchGestureRecognizer)
        imageViewOne.addGestureRecognizer(panGestureRecognizer)
        imageViewOne.addGestureRecognizer(rotationGestureRecognizer)
        
        imageViewTwo.userInteractionEnabled = true
        imageViewTwo.addGestureRecognizer(tapGestureRecognizer1)
        imageViewTwo.addGestureRecognizer(pinchGestureRecognizer1)
        imageViewTwo.addGestureRecognizer(panGestureRecognizer1)
        imageViewTwo.addGestureRecognizer(rotationGestureRecognizer1)
        
        imageViewThree.userInteractionEnabled = true
        imageViewThree.addGestureRecognizer(tapGestureRecognizer2)
        imageViewThree.addGestureRecognizer(pinchGestureRecognizer2)
        imageViewThree.addGestureRecognizer(panGestureRecognizer2)
        imageViewThree.addGestureRecognizer(rotationGestureRecognizer2)

        
        tableView.delegate = self
        
        topArr = [
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
        
        bodArr = [
            UIImage(named: "mid1.png")!,
            UIImage(named: "mid2.png")!,
            UIImage(named: "mid3.png")!,
            UIImage(named: "mid4.png")!,
            UIImage(named: "mid5.png")!,
            UIImage(named: "mid6.png")!,
            UIImage(named: "mid7.png")!,
            UIImage(named: "mid8.png")!,
            UIImage(named: "mid9.png")!,
            UIImage(named: "mid10.png")!
        ]
        
        botArr = [
            UIImage(named: "one.png")!,
            UIImage(named: "two.png")!,
            UIImage(named: "three.png")!,
            UIImage(named: "four.png")!,
            UIImage(named: "five.png")!,
            UIImage(named: "six.png")!,
            UIImage(named: "seven.png")!,
            UIImage(named: "eight.png")!,
            UIImage(named: "nine.png")!,
            UIImage(named: "ten.png")!
        ]
        
        self.combinedArr = [topArr, bodArr, botArr]
        

}
    
    //IMAGE FILTER FUNCTIONALITY
    
    private func applyFilterToImage(image : CIImage) -> CIImage {
        let filter = CIFilter(name: "CIPhotoEffectNoir")
        filter?.setDefaults()
        filter?.setValue(image, forKey: kCIInputImageKey)
        return (filter?.outputImage)!
    }
    
    @IBAction func filterPicture(sender: UIBarButtonItem) {
        
        if let image = imageView.image {
            let originalImage = CIImage(image: image)
            let outputImage = applyFilterToImage(originalImage!)
            let newImage = CIContext(options: nil).createCGImage(outputImage, fromRect: CGRect(origin: CGPoint(x: 0, y: 0 ), size: CGSize(width: image.size.height, height: image.size.width)))
            imageView.image = UIImage(CGImage: newImage, scale: image.scale, orientation: image.imageOrientation)
        }
    }
    
    func tap(gestureRecognizer: UITapGestureRecognizer) {
       
    
        var frame = imageViewOne.frame

        if (!expanded) {
            frame.size.height = frame.size.height * 2
            frame.size.width = frame.size.width * 2
            expanded = true
        } else {
            frame.size.height = frame.size.height / 2
            frame.size.width = frame.size.width / 2
            expanded = false
        }
        
        imageViewOne.frame = frame
        
        
    }
    
    func pinch(gestureRecognizer: UIPinchGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizerState.Began || gestureRecognizer.state == UIGestureRecognizerState.Changed {
            imageViewOne.transform = CGAffineTransformScale(imageViewOne.transform, gestureRecognizer.scale, gestureRecognizer.scale)
            gestureRecognizer.scale = 1
        }
    }
    
    func pan(gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizerState.Began || gestureRecognizer.state == UIGestureRecognizerState.Changed {
            let translation = gestureRecognizer.translationInView(imageViewOne.superview!)
            imageViewOne.center = CGPointMake(imageViewOne.center.x + translation.x, imageViewOne.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPointZero, inView: imageViewOne.superview)
        }
    }
    
    func rotate(gestureRecognizer: UIRotationGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizerState.Began || gestureRecognizer.state == UIGestureRecognizerState.Changed {
            imageViewOne.transform = CGAffineTransformRotate(imageViewOne.transform, gestureRecognizer.rotation)
            gestureRecognizer.rotation = 0
        }
    }
    
    
    
    
    
    
    func tap1(gestureRecognizer: UITapGestureRecognizer) {
        
        
        var frame = imageViewTwo.frame
        
        
        
        
        if (!expanded) {
            frame.size.height = frame.size.height * 2
            frame.size.width = frame.size.width * 2
            expanded = true
        } else {
            frame.size.height = frame.size.height / 2
            frame.size.width = frame.size.width / 2
            expanded = false
        }
        
        imageViewTwo.frame = frame
        
        
    }
    
    func pinch1(gestureRecognizer: UIPinchGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizerState.Began || gestureRecognizer.state == UIGestureRecognizerState.Changed {
            imageViewTwo.transform = CGAffineTransformScale(imageViewTwo.transform, gestureRecognizer.scale, gestureRecognizer.scale)
            gestureRecognizer.scale = 1
        }
    }
    
    func pan1(gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizerState.Began || gestureRecognizer.state == UIGestureRecognizerState.Changed {
            let translation = gestureRecognizer.translationInView(imageViewTwo.superview!)
            imageViewTwo.center = CGPointMake(imageViewTwo.center.x + translation.x, imageViewTwo.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPointZero, inView: imageViewTwo.superview)
        }
    }
    
    func rotate1(gestureRecognizer: UIRotationGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizerState.Began || gestureRecognizer.state == UIGestureRecognizerState.Changed {
            imageViewTwo.transform = CGAffineTransformRotate(imageViewTwo.transform, gestureRecognizer.rotation)
            gestureRecognizer.rotation = 0
        }
    }
    

    
    func tap2(gestureRecognizer: UITapGestureRecognizer) {
        
        
        var frame = imageViewThree.frame

        if (!expanded) {
            frame.size.height = frame.size.height * 2
            frame.size.width = frame.size.width * 2
            expanded = true
        } else {
            frame.size.height = frame.size.height / 2
            frame.size.width = frame.size.width / 2
            expanded = false
        }
        
        imageViewThree.frame = frame
        
        
    }
    
    func pinch2(gestureRecognizer: UIPinchGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizerState.Began || gestureRecognizer.state == UIGestureRecognizerState.Changed {
            imageViewThree.transform = CGAffineTransformScale(imageViewThree.transform, gestureRecognizer.scale, gestureRecognizer.scale)
            gestureRecognizer.scale = 1
        }
    }
    
    func pan2(gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizerState.Began || gestureRecognizer.state == UIGestureRecognizerState.Changed {
            let translation = gestureRecognizer.translationInView(imageViewThree.superview!)
            imageViewThree.center = CGPointMake(imageViewThree.center.x + translation.x, imageViewThree.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPointZero, inView: imageViewThree.superview)
        }
    }
    
    func rotate2(gestureRecognizer: UIRotationGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizerState.Began || gestureRecognizer.state == UIGestureRecognizerState.Changed {
            imageViewThree.transform = CGAffineTransformRotate(imageViewThree.transform, gestureRecognizer.rotation)
            gestureRecognizer.rotation = 0
        }
    }
    
    
    
    
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
    }

    
    //SCREENSHOT FUNCTIONALITY
    
    @IBAction func screenShot(sender: AnyObject) {
        let image = takeScreenshot()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        self.newCreature.createNewCreature(image)
        
        
    }
    
    func takeScreenshot() -> UIImage {
        let theView = self.finalView
        UIGraphicsBeginImageContextWithOptions(theView.bounds.size, true, 0.0)
        theView.drawViewHierarchyInRect(theView.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    //OPEN PHOTO LIBRARY FUNCTIONALITY
    
    @IBAction func openLibrary(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            imagePicker.allowsEditing = true
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.contentMode = .ScaleAspectFit
        imageView.image = chosenImage
        dismissViewControllerAnimated(true, completion: nil)
    }

        
    //TAKE PHOTO FUNCTIONALITY
    
    @IBAction func takePhoto(sender: UIBarButtonItem) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        presentViewController(imagePicker, animated: true, completion: nil)
        
    ////POSSIBLE WAY TO PRESENT BOTH LIBRARY AND CAMERA OPTIONS ON CAMERA VC:
//        func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
//            if(imagePicker.sourceType == UIImagePickerControllerSourceType.PhotoLibrary){
//                let button = UIBarButtonItem(title: "Take picture", style: UIBarButtonItemStyle.Plain, target: self, action: "showCamera")
//                viewController.navigationItem.rightBarButtonItem = button
//            }else{
//                let button = UIBarButtonItem(title: "Choose picture", style: UIBarButtonItemStyle.Plain, target: self, action: "choosePicture")
//                viewController.navigationItem.rightBarButtonItem = button
//                viewController.navigationController?.navigationBarHidden = false
//                viewController.navigationController?.navigationBar.translucent = true
//            }
//        }
//        
//        func showCamera(){
//            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
//        }
//        
//        func choosePicture(){
//            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
//        }
        
    }
    
    func imagePickerController1(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 52;
    }
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return 3
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("CellT",
                forIndexPath: indexPath) as! TableViewCell
            cell.whichCell = indexPath.row
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
    
    @IBAction func removeTapped(sender: AnyObject) {
        
        imageViewOne.image = nil
        imageViewTwo.image = nil
        imageViewThree.image = nil
    }
    
    
}
