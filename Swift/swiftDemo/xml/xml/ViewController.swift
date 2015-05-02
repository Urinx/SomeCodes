//
//  ViewController.swift
//  xml
//
//  Created by Eular on 15/4/21.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NSXMLParserDelegate {
    @IBOutlet weak var qL: UILabel!
    @IBOutlet weak var optA: UILabel!
    @IBOutlet weak var optB: UILabel!
    @IBOutlet weak var optC: UILabel!
    @IBOutlet weak var optD: UILabel!
    @IBOutlet weak var Abtu: UIButton!
    @IBOutlet weak var Bbtu: UIButton!
    @IBOutlet weak var Cbtu: UIButton!
    @IBOutlet weak var Dbtu: UIButton!
    
    struct Question {
        var text: String!
        var answer: String!
        var optA: String!
        var optB: String!
        var optC: String!
        var optD: String!
    }
    
    var questions = [Question]()
    var currentQuestion: Question!
    var currentIndex: Int = 0
    var currentSelect: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var parser = NSXMLParser(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("questions", ofType: "xml")!))
        parser?.delegate = self
        parser?.parse()
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        if elementName == "question" {
            currentQuestion = Question()
            currentQuestion.text = attributeDict["text"] as! String
            currentQuestion.answer = attributeDict["answer"] as! String
        } else if elementName == "opt" {
            var tag = attributeDict["tag"] as! String
            switch tag {
            case "A":
                currentQuestion.optA = attributeDict["text"] as! String
            case "B":
                currentQuestion.optB = attributeDict["text"] as! String
            case "C":
                currentQuestion.optC = attributeDict["text"] as! String
            case "D":
                currentQuestion.optD = attributeDict["text"] as! String
                questions.append(currentQuestion)
            default:
                return
            }
        }
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        // println(questions.count)
        var q = questions[currentIndex]
        qL.text = q.text
        optA.text = q.optA
        optB.text = q.optB
        optC.text = q.optC
        optD.text = q.optD
    }
    
    /*
    // 获取标签里的内容
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        var str = string?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        if str != "" {
            println(str!)
        }
    }
    */

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func btuStatusReset() {
        Abtu.selected = false
        Bbtu.selected = false
        Cbtu.selected = false
        Dbtu.selected = false
    }
    
    @IBAction func Atap(sender: AnyObject) {
        btuStatusReset()
        Abtu.selected = true
        currentSelect = "A"
    }
    
    @IBAction func Btap(sender: AnyObject) {
        btuStatusReset()
        Bbtu.selected = true
        currentSelect = "B"
    }
    
    @IBAction func Ctap(sender: AnyObject) {
        btuStatusReset()
        Cbtu.selected = true
        currentSelect = "C"
    }
    
    @IBAction func Dtap(sender: AnyObject) {
        btuStatusReset()
        Dbtu.selected = true
        currentSelect = "D"
    }
    
    @IBAction func submit(sender: AnyObject) {
        var c = questions[currentIndex % 3]
        if currentSelect == c.answer {
            currentIndex++
            UIAlertView(title: "恭喜你答对了", message: "以后的题目会越来越难哟", delegate: nil, cancelButtonTitle: "下一题").show()
            
            var q = questions[currentIndex % 3]
            qL.text = q.text
            optA.text = q.optA
            optB.text = q.optB
            optC.text = q.optC
            optD.text = q.optD
            btuStatusReset()
            
        } else {
            UIAlertView(title: "抱歉你答错了", message: "这么简单都不会，哼", delegate: nil, cancelButtonTitle: "重来").show()
            btuStatusReset()
        }
    }
}

