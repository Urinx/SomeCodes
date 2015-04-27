//
//  ViewController.swift
//  useCoreData
//
//  Created by Eular on 15/4/25.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        // 插入数据
        var row: AnyObject = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context!)
        row.setValue("Dudu", forKey: "name")
        row.setValue(12, forKey: "age")
        context?.save(nil)
        
        // 读取数据
        var f = NSFetchRequest(entityName: "Users")
        var dataArr = context?.executeFetchRequest(f, error: nil)
        println(dataArr?[0].valueForKey("name"))
        
        // 更新数据
        var data = dataArr?[0] as! NSManagedObject
        data.setValue("hehe", forKey: "name")
        data.setValue(22, forKey: "age")
        data.managedObjectContext?.save(nil)
        
        // 删除数据
        context?.deleteObject(dataArr?[0] as! NSManagedObject)
        context?.save(nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

