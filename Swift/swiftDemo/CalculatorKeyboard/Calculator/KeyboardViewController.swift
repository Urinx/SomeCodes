//
//  KeyboardViewController.swift
//  Calculator
//
//  Created by Eular on 15/7/6.
//  Copyright © 2015年 Eular. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet var nextBtn: UIButton!
    @IBOutlet weak var outputLabel: UILabel!
    
    
    var calculatorView: UIView!

    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .System)
    
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next", comment: "Title for 'Next Keyboard' button"), forState: .Normal)
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
    
        self.nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.nextKeyboardButton)
    
        let nextKeyboardButtonLeftSideConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 0.0)
        let nextKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        self.view.addConstraints([nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint])
        
        loadInterface()
    }
    
    func loadInterface() {
        // load the nib file
        let calculatorNib = UINib(nibName: "Calculator", bundle: nil)

        // instantiate the view
        self.calculatorView = calculatorNib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        // add the interface to the main view
        self.view.addSubview(calculatorView)

        // copy the background color
        self.view.backgroundColor = calculatorView.backgroundColor
        
        self.nextBtn.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
    }
    
    @IBAction func clearDisplay(sender: AnyObject) {
        self.outputLabel.text = "0"
    }
    
    @IBAction func num0(sender: AnyObject) {
        pressNum(0)
    }
    
    @IBAction func num1(sender: AnyObject) {
        pressNum(1)
    }
    
    @IBAction func num2(sender: AnyObject) {
        pressNum(2)
    }
    
    @IBAction func num3(sender: AnyObject) {
        pressNum(3)
    }
    
    @IBAction func num4(sender: AnyObject) {
        pressNum(4)
    }
    
    @IBAction func num5(sender: AnyObject) {
        pressNum(5)
    }
    
    @IBAction func num6(sender: AnyObject) {
        pressNum(6)
    }
    
    @IBAction func num7(sender: AnyObject) {
        pressNum(7)
    }
    
    @IBAction func num8(sender: AnyObject) {
        pressNum(8)
    }
    
    @IBAction func num9(sender: AnyObject) {
        pressNum(9)
    }
    
    @IBAction func insertText(sender: AnyObject) {
        self.textDocumentProxy.insertText(self.outputLabel.text!)
    }
    
    func pressNum(n:Int) {
        if self.outputLabel.text?.characters.count < 9 {
            if self.outputLabel.text != "0" {
                self.outputLabel.text = "\(self.outputLabel.text!)\(n)"
            }
            else {
                self.outputLabel.text = "\(n)"
            }
        }
    }
    
    // ---------------------------------------

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    override func textWillChange(textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
    
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.blackColor()
        }
        self.nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
    }

}
