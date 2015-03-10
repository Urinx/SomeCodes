
// P.198
// For Loops
// for-in loops
let base = 3
let power = 10
var answer = 1
for _ in 1...power {
    answer *= base
}
println("\(base) to the power of \(power) is \(answer)")

// traditional C-style
for var i = 0; i < 3; i++ {
    println("index is \(i)")
}

// P.206
// While Loops
// Snakes and Ladders Game
let finalSquare = 25
var board = [Int](count: finalSquare+1, repeatedValue: 0)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
var square = 0
var diceRoll = 0
while square < finalSquare {
    // roll the dice
    if ++diceRoll == 7 {diceRoll = 1}
    square += diceRoll
    if square < board.count {
        square += board[square]
    }
}

// P.216
// Conditional Statements
var temperatureInFahrenheit = 73
if temperatureInFahrenheit <= 32 {
    println("It's very cold. Consider wearing a scarf.")
} else {
    println("It's not that cold. Wear a t-shirt.")
}


// P.220
// Switch
let someCharacter: Character = "e"
switch someCharacter {
    case "a", "e", "i", "o", "u":
        println("\(someCharacter) is a vowel")
    case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
        println("\(someCharacter) is a consonant")
    default:
        println("\(someCharacter) is not a vowel or a consonant")
}

// Range Matching
let a = 4
switch a {
    case 0: println("0")
    case 1...10: println("1~10")
    default: println(">10")
}

// P.228
// Tuples
let somePoint = (1, 1)
switch somePoint {
    case (0,0): println("(0,0) is at the origin")
    case (_,0): println("(\(somePoint.0), 0) is on the x-axis")
    case (0,_): println("(0, \(somePoint.1)) is on the y-axis")
    case (-2...2, -2...2): println("(\(somePoint.0), \(somePoint.1)) is inside the box")
    default: println("(\(somePoint.0), \(somePoint.1)) is outside of the box")
}

// Value Binding
let anotherPoint = (2, 0)
switch anotherPoint {
    case (let x, 0): println("on the x-axis with an x value of \(x)")
    case (0, let y): println("on the y-axis with a y value of \(y)")
    case let (x, y): println("somewhere else at (\(x), \(y))")
}

// P.234
// Where
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
    case let (x, y) where x == y: println("(\(x), \(y)) is on the line x == y")
    case let (x, y) where x == -y: println("(\(x), \(y)) is on the line x == -y")
    case let (x, y): println("(\(x), \(y)) is just some arbitrary point")
}

// P.238
// Continue
let puzzleInput = "great minds think alike"
var puzzleOutput = [Character]()
for character in puzzleInput {
    switch character {
        case "a", "e", "i", "o", "u", " ":
            continue
        default:
            puzzleOutput.append(character)
    }
}

// Break
// ...

// Fallthrough
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2,3,5,7,11,13,17,19:
    description += " aprime number, and also"
    fallthrough
default:
    description += " an integer."
}
println(description)

// P.247
// Labeled Statements
forLoop: for i in 1...10 {
    switch i {
    case 8: break forLoop
    case 1,3,5:
        continue forLoop
    default: println(i)
    }
}
