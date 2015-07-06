//
//  ViewController.swift
//  CalculatorKeyboard
//
//  Created by Eular on 15/7/6.
//  Copyright © 2015年 Eular. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var testInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.testInput.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

