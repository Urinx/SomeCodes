//
//  swiftHello.swift
//  obcCallSwiftCode
//
//  Created by Eular on 15/4/21.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import UIKit

class swiftHello: NSObject {
    func sayHello() {
        UIAlertView(title: "Swift", message: "hello swift", delegate: nil, cancelButtonTitle: "Ok").show()
    }
}
