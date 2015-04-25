//
//  ViewController.swift
//  video
//
//  Created by Eular on 15/4/21.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import UIKit
import MediaPlayer
import MobileCoreServices

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var mpPlayer: MPMoviePlayerViewController!
    var piker: UIImagePickerController!
    var fileURL: NSURL?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func play(sender: AnyObject) {
        mpPlayer = MPMoviePlayerViewController(contentURL: NSBundle.mainBundle().URLForResource("0", withExtension: "mp4"))
        self.presentMoviePlayerViewControllerAnimated(mpPlayer)
    }

    @IBAction func startRec(sender: AnyObject) {
        piker = UIImagePickerController()
        piker.mediaTypes = [kUTTypeMovie!]
        piker.sourceType = UIImagePickerControllerSourceType.Camera
        piker.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.Video
        piker.delegate = self
        
        self.presentViewController(piker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        fileURL = info[UIImagePickerControllerMediaURL] as? NSURL
        piker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        println("canceled")
        piker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func playRec(sender: AnyObject) {
        if let video = fileURL {
            mpPlayer = MPMoviePlayerViewController(contentURL: video)
            self.presentMoviePlayerViewControllerAnimated(mpPlayer)
        }
    }
    
}

