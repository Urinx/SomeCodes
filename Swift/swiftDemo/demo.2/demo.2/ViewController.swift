//
//  ViewController.swift
//  demo.2
//
//  Created by Eular on 15-3-20.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
                            
    @IBOutlet var name: UITextField
    
    @IBOutlet var gentle: UISegmentedControl
    
    @IBOutlet var birth: UIDatePicker
    
    @IBOutlet var heightSlide: UISlider
    
    @IBOutlet var heightLabel: UILabel
    
    @IBOutlet var house: UISwitch
    
    @IBOutlet var result: UILabel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        name.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        name.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        name.resignFirstResponder()
        return true
    }
    
    func getAge() -> Int {
        let now = NSDate()
        let gregorian = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let components = gregorian.components(NSCalendarUnit.YearCalendarUnit, fromDate: birth.date, toDate: now, options: NSCalendarOptions(0))
        return components.year
    }

    @IBAction func heightChange(sender: AnyObject) {
        var slide = sender as UISlider
        var h = Int(slide.value)
        heightSlide.value = Float(h)
        heightLabel.text = "\(h)厘米"
    }

    @IBAction func sureClick(sender: AnyObject) {
        name.resignFirstResponder()
        
        if !name.text.isEmpty {
            let nameStr = name.text
            let gentleStr = ["高富帅","白富美"][gentle.selectedSegmentIndex]
            let hasHouse = (house.on ? "有":"没") + "房"
            let heightStr = heightLabel.text
            let ageStr = "\(getAge())岁"
        
            result.text = "\(nameStr), \(ageStr), \(gentleStr), 身高\(heightStr), \(hasHouse), 求交往"
        } else {
            result.text = "请输入姓名"
        }
    }
    
}

