//
//  ViewController.swift
//  sensor
//
//  Created by Eular on 15/4/19.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import UIKit
import CoreMotion
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    var cmm: CMMotionManager!
    var cl: CLLocationManager!
    var q: NSOperationQueue!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        cmm = CMMotionManager()
        cl = CLLocationManager()
        q = NSOperationQueue()
        
        cl.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        startAccelerometer()
        startGyro()
        startProximity()
        startBattery()
        startHeading()
    }
    
    override func viewWillDisappear(animated: Bool) {
        stopAccelerometer()
        stopGyro()
        stopProximity()
        stopBattery()
        stopHeading()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 加速度传感器
    func startAccelerometer() {
        // 配置更新频率
        cmm.accelerometerUpdateInterval = 1.0
        
        if cmm.accelerometerAvailable && !cmm.accelerometerActive {
            cmm.startAccelerometerUpdatesToQueue(q, withHandler: {
                (data:CMAccelerometerData!, err: NSError!) in
                println("acceler data:\(data)")
            })
        } else {
            println("模拟器不支持加速度传感器")
        }
    }
    
    func stopAccelerometer() {
        if cmm.accelerometerActive {
            cmm.stopAccelerometerUpdates()
        }
    }
    
    // 陀螺仪传感器
    func startGyro() {
        cmm.gyroUpdateInterval = 1.0
        
        if cmm.gyroAvailable && !cmm.gyroActive {
            cmm.startGyroUpdatesToQueue(q, withHandler: {
                (data: CMGyroData!, err: NSError!) in
                println("gyro data:\(data)")
            })
        } else {
            println("模拟器不支持陀螺仪传感器")
        }
    }
    
    func stopGyro() {
        if cmm.gyroActive {
            cmm.stopGyroUpdates()
        }
    }
    
    // 距离传感器
    func startProximity() {
        UIDevice.currentDevice().proximityMonitoringEnabled = true
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("proximityChanged"), name: UIDeviceProximityStateDidChangeNotification, object: nil)
    }
    
    func proximityChanged() {
        println("\(UIDevice.currentDevice().proximityState)")
        println(">>>")
    }
    
    func stopProximity() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIDeviceProximityStateDidChangeNotification, object: nil)
    }
    
    // 电源传感器
    func startBattery() {
        UIDevice.currentDevice().batteryMonitoringEnabled = true
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("batteryChanged"), name: UIDeviceBatteryLevelDidChangeNotification, object: nil)
    }
    
    func batteryChanged() {
        println("\(UIDevice.currentDevice().batteryLevel)")
    }
    
    func stopBattery() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIDeviceBatteryLevelDidChangeNotification, object: nil)
    }
    
    // 磁场传感器
    func startHeading() {
        cl.startUpdatingHeading()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateHeading newHeading: CLHeading!) {
        println(newHeading)
    }
    
    func stopHeading() {
        cl.stopUpdatingHeading()
    }
}

