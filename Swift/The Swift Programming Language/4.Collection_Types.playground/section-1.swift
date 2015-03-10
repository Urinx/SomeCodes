
// P.167
// Array
var shoppingList: [String] = ["Eggs", "Milk"]
println("The shopping list contains \(shoppingList.count) items.")

shoppingList.append("Flour")
shoppingList += ["Baking Powder", "Chocolate Spread", "Cheese", "Butter"]

var firstItem = shoppingList[0]
shoppingList[0] = "Six eggs"

shoppingList[4...6] = ["Bananas", "Apples"]

shoppingList.insert("Maple Syrup", atIndex: 0)

let mapleSyrup = shoppingList.removeAtIndex(0)
let apples = shoppingList.removeLast()

for item in shoppingList {
    println(item)
}

// Enumerate
for (index, value) in enumerate(shoppingList) {
    println("Item \(index+1): \(value)")
}

// Creating and Initializing an Array
var someInts = [Int]()
var threeDoubles = [Double](count: 3, repeatedValue: 0.0)

// P.182
// Dictionaries
var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

// Accessing and Modifying
println("The airports dictionary contains \(airports.count) items.")

airports["LHR"] = "London Heathrow"

if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
    println("The old value for DUB was \(oldValue).")
}

airports["APL"] = "Apple International"
airports["APL"] = nil

if let removedValue = airports.removeValueForKey("DUB") {
    println("The removed airport's name is \(removedValue).")
} else {
    println("The airports dictionary does not contain a value for DUB.")
}

// P.192
// Iterating Over a Dictionary
for (airportCode, airportName) in airports {
    println("\(airportCode): \(airportName)")
}

for airportCode in airports.keys {
    println("Airport code: \(airportCode)")
}

let airportNames = [String](airports.values)

// Creating an Empty Dictionary
var namesOfIntegers = [Int: String]()
namesOfIntegers[16] = "sixteen"
namesOfIntegers = [:]
