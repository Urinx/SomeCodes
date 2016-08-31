//: Playground - noun: a place where people can play

import UIKit

class Person: NSObject {
    var firstName: String
    var lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    override func valueForUndefinedKey(key: String) -> AnyObject? {
        return ""
    }
}

let peter = Person(firstName: "Cook", lastName: "Peter")

peter.firstName
peter.valueForKey("lastName")
peter.valueForKey("noExist")
