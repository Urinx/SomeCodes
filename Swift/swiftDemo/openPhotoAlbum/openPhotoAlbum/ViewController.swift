//
//  ViewController.swift
//  openPhotoAlbum
//
//  Created by Eular on 15/4/19.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func openPhotoAlbum(sender: AnyObject) {
        var imgPicker = UIImagePickerController()
        imgPicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imgPicker.delegate = self
        self.presentViewController(imgPicker, animated: true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        img.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}

