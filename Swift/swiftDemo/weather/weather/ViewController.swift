//
//  ViewController.swift
//  weather
//
//  Created by Eular on 15/4/8.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let weatherIconMap = ["多云":"halfsun","小雨":"mistyrain","阴":"cloud","阵雨":"tempest","晴":"sun","大雨":"hail","雪":"snow","风":"wind","中雨":"rain","雾":"fog"]
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var L1: UILabel!
    @IBOutlet weak var L2: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getWeather()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func close(segue: UIStoryboardSegue) {
        // println("close")
    }
    
    func getWeather() {
        var apiUrl = "http://www.weather.com.cn/adat/cityinfo/101010100.html"
        var url = NSURL(string: apiUrl)
        var data = NSData(contentsOfURL: url!, options: NSDataReadingOptions.DataReadingUncached, error: nil)
        var json = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil) as NSDictionary
        var weatherinfo = json.objectForKey("weatherinfo") as NSDictionary
        
        
        var temp1 = weatherinfo.objectForKey("temp1") as String
        var temp2 = weatherinfo.objectForKey("temp2") as String
        var city = weatherinfo.objectForKey("city") as String
        var weather = weatherinfo.objectForKey("weather") as String
        
        var weatherIconName: String = "sun"
        for (k, v) in weatherIconMap {
            if weather.hasSuffix(k) {
                weatherIconName = v
            }
        }
        
        L1.text = "\(temp2)~\(temp1)"
        L2.text = "\(city) \(weather)"
        weatherIcon.image = UIImage(named: weatherIconName)
    }
}

