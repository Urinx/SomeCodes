//
//  ViewController.swift
//  Todo
//
//  Created by Eular on 15-3-26.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import UIKit

var todoList = [TodoModel]()
var filteredTodoList = [TodoModel]()

func dateFromString(dateStr: String) -> NSDate {
    var dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.dateFromString(dateStr)
}

func dateFormatAsLocale(date: NSDate) -> String {
    let locale = NSLocale.currentLocale()
    let dateFormat = NSDateFormatter.dateFormatFromTemplate("yyyy-MM-dd", options: 0, locale: locale)
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = dateFormat
    return dateFormatter.stringFromDate(date)
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate {
                            
    @IBOutlet var todoTable: UITableView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        todoList = [TodoModel(id: "1", image: "dribbble", title: "Go to eat", date: dateFromString("2015-3-25")),
        TodoModel(id: "2", image: "cloud", title: "Sleep now", date: dateFromString("2015-3-26")),
        TodoModel(id: "3", image: "lastfm", title: "Work harder", date: dateFromString("2015-3-27")),
        TodoModel(id: "4", image: "stumbleupon", title: "Run along", date: dateFromString("2015-3-28"))]
        
        // Add edit button
        navigationItem.leftBarButtonItem = editButtonItem()
        
        // Hide searchBar
        var contentOffset = todoTable.contentOffset
        contentOffset.y += searchDisplayController!.searchBar.frame.size.height
        todoTable.contentOffset = contentOffset
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // TableViewDataSource
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        if todoTable == searchDisplayController.searchResultsTableView {
            // Fix this!
            // Why can't go into this satuation?
            return filteredTodoList.count
        }
        return todoList.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = todoTable.dequeueReusableCellWithIdentifier("todoCell") as UITableViewCell
        
        var todo: TodoModel
        
        if todoTable == searchDisplayController.searchResultsTableView {
            // Fix this!
            // Why can't go into this satuation?
            todo = filteredTodoList[indexPath.row] as TodoModel
        } else {
            todo = todoList[indexPath.row] as TodoModel
        }
        
        var imgUI = cell.viewWithTag(100) as UIImageView
        var titleUI = cell.viewWithTag(101) as UILabel
        var subtitleUI = cell.viewWithTag(102) as UILabel
        
        imgUI.image = UIImage(named: todo.image)
        titleUI.text = todo.title
        subtitleUI.text = dateFormatAsLocale(todo.date)
        
        return cell
    }
    
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            todoList.removeAtIndex(indexPath.row)
            todoTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return editing
    }
    
    // UITableViewDelegate
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 55.0
    }
    
    // SearchDelegate
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        filteredTodoList = todoList.filter(){ !($0.title.rangeOfString(searchString).isEmpty) }
        return true
    }
    
    // Drag & Move
    func tableView(tableView: UITableView!, moveRowAtIndexPath sourceIndexPath: NSIndexPath!, toIndexPath destinationIndexPath: NSIndexPath!) {
        let todo = todoList.removeAtIndex(sourceIndexPath.row)
        todoList.insert(todo, atIndex: destinationIndexPath.row)
    }
    
    // Edit Mode
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        todoTable.setEditing(editing, animated: animated)
    }
    
    // Ok Back
    @IBAction func close(segue: UIStoryboardSegue) {
        println("Ok button back")
    }

    // Edit item
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if segue.identifier == "editTodo" {
            var vc = segue.destinationViewController as TodoItemViewController
            var indexPath = todoTable.indexPathForSelectedRow()
            
            if let index = indexPath {
                vc.editedTodo = todoList[index.row]
                vc.index = index.row
            }
        }
    }
}

