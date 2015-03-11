
// P.254
// Defining
func sayHelloWorld() -> String {
    return "Hello, world"
}
println(sayHelloWorld())

func halfOpenRangeLength(start: Int, end: Int) -> Int {
    return end - start
}
println(halfOpenRangeLength(1, 10))

// The return value of a function can beignored when it is called
func printAndCount(stringToPrint: String) -> Int {
    println(stringToPrint)
    return countElements(stringToPrint)
}

func printWithoutCounting(stringToPrint: String) {
    printAndCount(stringToPrint)
}

printWithoutCounting("Hello, world")

// Multiple and Optional Tuple Return Values
func minMax(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty { return nil }
    var currentMin = array[0]
    var currentMax = array[0]
    for i in array[1..<array.count] {
        if i < currentMin {
            currentMin = i
        } else if i > currentMax {
            currentMax = i
        }
    }
    return (currentMin, currentMax)
}
let bounds = minMax([8,-6,2,109,3,71])

// P.269
// Function Parameter Names
func join(string s1:String, toString s2:String, withJoiner joiner:String) -> String {
    return s1+joiner+s2
}

join(string: "hello", toString: "world", withJoiner: ", ")

// Shorthand External Parameter Names
func containsCharacter(#string: String, #characterToFind: Character) -> Bool {
    for character in string {
        if character == characterToFind {
            return true
        }
    }
    return false
}

let containsAVee = containsCharacter(string: "aardvark", characterToFind: "v")

// Default Parameter Value
func join2(s1: String, #s2: String, withJoiner joiner: String = " ") -> String {
    return s1 + joiner + s2
}

join2("hello", s2: "world", withJoiner: "-")


// P.278
// Variadic Parameters
func arithmeticMean(numbers: Double...) -> Double {
    var total: Double = 0
    for n in numbers {
        total += n
    }
    return total / Double(numbers.count)
}
arithmeticMean(1,2,3,4,5)

// Variable Parameters
func alignRight(var string: String, count: Int, pad: Character) -> String {
    let amountToPad = count - countElements(string)
    if amountToPad < 1 {
        return string
    }
    let padString = String(pad)
    for _ in 1...amountToPad {
        string = padString + string
    }
    return string
}
let originalString = "hello"
let paddedString = alignRight(originalString, 10, "_")

// P.285
// In-Out Parameters
func swapTwoInts(inout a: Int, inout b: Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
println("someInt is now \(someInt), and anotherInt is now \(anotherInt)")

// P.189
// Function Types
func addTwoInts(a: Int, b: Int) -> Int {
    return a + b
}
var mathFunction: (Int, Int) -> Int = addTwoInts
println("Result: \(mathFunction(2, 3))")

// Function Types as Parameter Types
func printMathResult(mathFunction: (Int, Int) -> Int, a: Int, b: Int) {
    println("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)

// Function Types as Return Types
func stepForward(input: Int) -> Int {
    return input + 1
}
func stepBackward(input: Int) -> Int {
    return input - 1
}
func chooseStepFunction(backwards: Bool) -> (Int) -> Int {
    return backwards ? stepBackward : stepForward
}

var currentValue = 3
let moveNearerToZero = chooseStepFunction(currentValue > 0)

// Nested Functions
func nestedFunction(backwards: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int {
        return input + 1
    }
    func stepBackward(input: Int) -> Int {
        return input - 1
    }
    return backwards ? stepBackward : stepForward
}
