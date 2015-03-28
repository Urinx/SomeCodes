//
//  TodoItemViewController.swift
//  Todo
//
//  Created by Eular on 15-3-26.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import UIKit

class TodoItemViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var icloudBtu: UIButton
    @IBOutlet var dribbbleBtu: UIButton
    @IBOutlet var lastfmBtu: UIButton
    @IBOutlet var stumBtu: UIButton
    @IBOutlet var todoText: UITextField
    @IBOutlet var datePicker: UIDatePicker
    
    var editedTodo: TodoModel?
    var index: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        todoText.delegate = self
        
        if let todo = editedTodo {
            navigationController.title = "Edit"
            
            switch todo.image {
            case "cloud":
                icloudBtu.selected = true
            case "dribbble":
                dribbbleBtu.selected = true
            case "lastfm":
                lastfmBtu.selected = true
            case "stumbleupon":
                stumBtu.selected = true
            default:
                btuStatusReset()
            }
            
            todoText.text = todo.title
            // datePicker.date = todo.date
            datePicker.setDate(todo.date, animated: false)
            
        } else {
            navigationController.title = "Add"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        todoText.resignFirstResponder()
    }
    
    // UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        todoText.resignFirstResponder()
        return true
    }
    
    // Button Tapped
    func btuStatusReset() {
        icloudBtu.selected = false
        dribbbleBtu.selected = false
        lastfmBtu.selected = false
        stumBtu.selected = false
    }
    
    @IBAction func icloudTapped(sender: AnyObject) {
        btuStatusReset()
        icloudBtu.selected = true
    }
    
    @IBAction func dribbbleTapped(sender: AnyObject) {
        btuStatusReset()
        dribbbleBtu.selected = true
    }
    
    @IBAction func lastfmTapped(sender: AnyObject) {
        btuStatusReset()
        lastfmBtu.selected = true
    }
    
    @IBAction func stumTapped(sender: AnyObject) {
        btuStatusReset()
        stumBtu.selected = true
    }
    
    @IBAction func okTapped(sender: AnyObject) {
        var image: String?
        if icloudBtu.selected {
            image = "cloud"
        } else if dribbbleBtu.selected {
            image = "dribbble"
        } else if lastfmBtu.selected {
            image = "lastfm"
        } else if stumBtu.selected {
            image = "stumbleupon"
        }
        
        var uuid = NSUUID.UUID().UUIDString
        var todoStr = todoText.text
        var date = datePicker.date
        
        if editedTodo != nil {
            editedTodo!.image = image!
            editedTodo!.title = todoStr
            editedTodo!.date = date
            println("There has a bug but I can't fix it!")
        } else {
            var todoItem = TodoModel(id: uuid, image: image!, title: todoStr, date: date)
            todoList.append(todoItem)
        }
    }
    
}
