//
//  ViewController.swift
//  musicAPI
//
//  Created by Eular on 15/4/20.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class ViewController: UIViewController, MPMediaPickerControllerDelegate {
    
    var avPlayer: AVAudioPlayer!
    var libraryPicker: MPMediaPickerController!
    var mpPlayer: MPMusicPlayerController!
    var avRec: AVAudioRecorder!
    var audioFileURL: NSURL!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        avPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("thank4yourLove", ofType: "mp3")!), error: nil)
        
        libraryPicker = MPMediaPickerController(mediaTypes: MPMediaType.Music)
        libraryPicker.allowsPickingMultipleItems = true
        libraryPicker.delegate = self
        
        mpPlayer = MPMusicPlayerController.systemMusicPlayer()
        
        audioFileURL = (NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.AllDomainsMask)[0] as! NSURL).URLByAppendingPathComponent("rec")
        avRec = AVAudioRecorder(URL: audioFileURL, settings: nil, error: nil)
        avRec.prepareToRecord()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func avPlay(sender: AnyObject) {
        avPlayer.play()
    }

    @IBAction func avPause(sender: AnyObject) {
        avPlayer.pause()
    }

    @IBAction func avStop(sender: AnyObject) {
        avPlayer.stop()
        avPlayer.currentTime = 0
    }
    
    @IBAction func mpPlay(sender: AnyObject) {
        var p = MPMoviePlayerViewController(contentURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("thank4yourLove", ofType: "mp3")!))
        // self.presentViewController(p, animated: true, completion: nil)
        self.presentMoviePlayerViewControllerAnimated(p)
    }
    
    @IBAction func selectLibraryMusics(sender: AnyObject) {
        self.presentViewController(libraryPicker, animated: true, completion: nil)
    }
    
    func mediaPicker(mediaPicker: MPMediaPickerController!, didPickMediaItems mediaItemCollection: MPMediaItemCollection!) {
        mediaPicker.dismissViewControllerAnimated(true, completion: nil)
        mpPlayer.setQueueWithItemCollection(mediaItemCollection)
        mpPlayer.play()
        
        // 输出歌曲名字
        var firstName: String = mediaItemCollection.items[0].valueForProperty(MPMediaItemPropertyAlbumTitle) as! String
        println("\(firstName)")
    }
    
    func mediaPickerDidCancel(mediaPicker: MPMediaPickerController!) {
        mediaPicker.dismissViewControllerAnimated(true, completion: nil)
        println("canceled")
    }
    
    @IBAction func startRec(sender: AnyObject) {
        avRec.record()
    }
    
    @IBAction func stopRec(sender: AnyObject) {
        avRec.stop()
    }
    
    @IBAction func playRec(sender: AnyObject) {
        avPlayer = AVAudioPlayer(contentsOfURL: audioFileURL, error: nil)
        avPlayer.prepareToPlay()
        avPlayer.play()
    }
    
}

