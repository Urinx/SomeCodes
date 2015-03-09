
// P.108
// Assignment Operator
let (x, y) = (1, 2)
// assignment operator does not return a value
// if x = y { ... } is wrong

// Arithmetic Operator
"hello, "+"world"
var a = 0
var b = ++a
var c = a++
a += 2
var d = a > 3 ? 22:2

// Nil Coalescing Operator
// a ?? b (is equal to) a != nil ? a! : b
let defaultColorName = "red"
var userDefinedColorName: String?
// var colorNameToUse = userDefinedColorName ?? defaultColorName

// P.126
// Range Operators
for i in 1...5 {
    println("\(i) times 5 is \(i*5)")
}

let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count
for i in 0..<count {
    println("Person \(i+1) is called \(names[i])")
}