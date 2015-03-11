
// P.300
// Closures

// The Sorted Function
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backwards(s1: String, s2: String) -> Bool {
    return s1 > s2
}
var reversed = sorted(names, backwards)

// Closure Expression
// default valuse cannot be provided!
reversed = sorted(names, { (s1: String, s2: String) -> Bool in
    return s1 > s2
})

// Inferring Type From Context
reversed = sorted(names, { s1, s2 in return s1 > s2 })

// Implicit Returns from Single-Expression Closures
reversed = sorted(names, { s1, s2 in s1 < s2})

// Shorthand Argument Names
reversed = sorted(names, { $0 > $1 })

// Operator Function
reversed = sorted(names, >)

// P.310
// Trailing Closures
reversed = sorted(names) { $0 > $1 }

// P.313
// Map
let digitNames = [
    0: "Zero", 1: "One", 2: "Two", 3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

let strings = numbers.map {
    (var number) -> String in
    var output = ""
    while number > 0 {
        output = digitNames[number % 10]! + output
        number /= 10
    }
    return output
}

// P.317
// Capturing Values
func makeIncrementor(forIncrement amount: Int = 1) -> () -> Int {
    var runningTotal = 0
    func incrementor() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementor
}
let incrementByOne = makeIncrementor()
incrementByOne()
incrementByOne()
incrementByOne()
// If you create s second incrementor, it will have its own stored reference to a new, separate variable
