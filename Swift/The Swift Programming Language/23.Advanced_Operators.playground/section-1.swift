
// P.787
// Advanced Operators

// Bitwise Operators

// NOT
let initialBits: UInt8 = 0b00001111
let invertedBits = ~initialBits

// AND
let firstSixBits: UInt8 = 0b11111100
let lastSixBits: UInt8 = 0b00111111
let middleFourBits = firstSixBits & lastSixBits

// OR
let someBits: UInt8 = 0b10110010
let moreBits: UInt8 = 0b01011110
let combinedbits = someBits | moreBits

// XOR
let firstBits: UInt8 = 0b00010100
let otherBits: UInt8 = 0b00000101
let outputBits = firstBits ^ otherBits

// Bitwise Left and Right Shift Operators
let shiftBits: UInt8 = 4
shiftBits << 1
shiftBits << 2
shiftBits << 5
shiftBits << 6
shiftBits >> 2

let pink: UInt32 = 0xCC6699
let redComponent = (pink & 0xFF0000) >> 16
let greenComponent = (pink & 0x00FF00) >> 8
let blueComponent = pink & 0x0000FF

// Shift Behavior for Signed Integers

// P.802
// Overflow Operations
var willOverflow = UInt8.max
willOverflow = willOverflow &+ 1

var willUnderflow = UInt8.min
willUnderflow = willUnderflow &- 1

var signedUnderflow = Int8.min
signedUnderflow = signedUnderflow &- 1

// Division by Zero
let x = 1
let y = x &/ 0

// Precedence and Associativity

// Operator Functions
struct Vector2D {
    var x = 0.0, y = 0.0
}
func + (left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y + right.y)
}

let vector = Vector2D(x: 3.0, y: 1.0)
let anotherVector = Vector2D(x: 2.0, y: 4.0)
let combinedVector = vector + anotherVector

// Prefix and Postfix Operators
@prefix func - (vector: Vector2D) -> Vector2D {
    return Vector2D(x: -vector.x, y: -vector.y)
}

func += (inout left: Vector2D, inout right: Vector2D) {
    left = left + right
}

@prefix func ++ (inout vector: Vector2D) -> Vector2D {
    var one = Vector2D(x: 1.0, y: 1.0)
    vector += one
    return vector
}

@postfix func ++ (inout vector: Vector2D) -> Vector2D {
    let preVector = vector
    var one = Vector2D(x: 1.0, y: 1.0)
    vector += one
    return preVector
}

let positive = Vector2D(x: 3.0, y: 4.0)
let negative = -positive

var original = Vector2D(x: 1.0, y: 2.0)
var vectorToAdd = Vector2D(x: 3.0, y: 4.0)
original += vectorToAdd

let positiveMinus = vectorToAdd++

// Equivalence Operators
func == (left: Vector2D, right: Vector2D) -> Bool {
    return (left.x == right.x) && (left.y == right.y)
}

func != (left: Vector2D, right: Vector2D) -> Bool {
    return !(left == right)
}

// Custom Operators
@prefix func +++ (inout vector: Vector2D) -> Vector2D {
    vector += vector
    return vector
}

// Precedence and Associativity for Custom Infix Operators
@infix func +- (left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y - right.y)
}

