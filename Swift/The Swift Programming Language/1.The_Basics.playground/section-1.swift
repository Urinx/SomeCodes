
// P.57
// Constants & Variables
let maximumNumberOfLoginAttempts = 10
var currentLoginAttempt = 0

// declare multiple contants & multiple variables
// on a single line, separated by commas:
var x=0.0, y=0.0, z=0.0

// P.59
// Type Annotations
var welcomeMessage: String
welcomeMessage = "Hello"

// define multiple related variables of the same type on a single line
var red, green, blue: Double

// P.61
// Naming Constants & Variables
let π = 3.14159
let 你好 = "你好世界"
let 🐶🐮 = "dogcow"

// Print
println(welcomeMessage)
println("The welcomeMessage is \(welcomeMessage)")

// Comments
// this is a comment
/* this is also a comment,
but written over multiple lines */

// Semicolons
let cat = "🐱"; println(cat)

// P.67
// Intergers
// Integer Bounds
let minValue = UInt8.min
let maxValue = UInt8.max

/*
On a 32-bit platform, Int is the same size as Int32
On a 64-bit platform, Int is the same size as Int64
*/

// Floating-Point Numbers
// Double : 64-bit
// Float  : 32-bit

// P.74
// Numberic Literals
let decimalInt = 17
let binaryInt = 0b10001
let octalInt = 0o21
let hexadecimalInt = 0x11
let exp = 1.25e2
let exp2 = 0xFp2 // 15x2^2
let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1

// P.81
// Type Aliases
typealias AudioSample = UInt16
var maxAmplitudeFound = AudioSample.max

// Booleans
let orangeAreOrange = true
let turnipsAreDelicious = false

// P.85
// Tuples
let http404Error = (404, "Not Found")

// decompose tuple into separate constants
let (statusCode, statusMessage) = http404Error
println("The status code is \(statusCode)")

// ignore parts of the tuple with an underscore _
let (justTheStatusCode, _) = http404Error

// access using index
println("The status code is \(http404Error.0)")

// name the element
let http200Status = (statusCode: 200, description: "OK")
println("The status code is \(http200Status.statusCode)")

// P.89
// Optionals
let possibleNumber = "123"
let convertedNumber = possibleNumber.toInt()
// convertedNumber is inferred to be of type "int?",
// or "optional Int"

// nil
var serverresponseCode: Int? = 404
serverresponseCode = nil

// automatically set to nil
var surveyAnswer: String?

// Forced Unwrapping
if convertedNumber != nil {
    println("convertedNumber has an integer value of \(convertedNumber!)")
}

// P.95
// Optional Binding
if let actualNumber = possibleNumber.toInt() {
    println("\'\(possibleNumber)\' has an integer value of \(actualNumber)")
} else {
    println("\'\(possibleNumber)\' could not be converted to an integer")
}

// P.97
// Implicitly Unwrapped Optionals
let possibleString: String? = "An optional string"
let forcedstring: String = possibleString!
let assumedString: String! = "An implicitly unwrapped optional string"
let implicitString: String = assumedString

// P.101
// Assertions
let age = -3
assert(age >= 0, "A person's age cannot be less than zero")
