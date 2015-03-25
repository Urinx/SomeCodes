//
//  ViewControllerExtension.swift
//  demo.3
//
//  Created by Eular on 15-3-24.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import Foundation
import UIKit

extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        return girls.count
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {
        return girls[row]
    }
}