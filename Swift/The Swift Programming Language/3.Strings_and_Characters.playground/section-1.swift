
// P.136
// Initializing
var emptyString = ""
var anotherEmptyString = String()

if emptyString.isEmpty {
    println("Nothing to see here")
}

// P.140
// Work with Characters
for character in "Dong!" {
    println(character)
}
let yenSign: Character = "¥"

// Concatenating
var welcome = "hello"+" there"
let exclamationMark: Character = "!"
// welcome.append(exclamationMark)

// Interpolation
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"

// P.144
// Unicode
let wiseWords = "\"Imagination is ore important than knowledge\" - Einstein"
// let dollarSign = "\u{24}" in the official book?
let dollarSign = "\u0024"
let blackHeart = "\u2665"
// let sparklingHeart = "\u{1F496}" in the official book?
let sparklingHeart = "\U0001F496"

// Extended Grapheme Clusters
let eAcute: Character = "\u00E9"
let combinedEAcute: Character = "\u0065\u0301"
let precomposed: Character = "\uD55C"
let decomposed: Character = "\u1112\u1161\u11AB"
let enclosedEAcute:Character = "\u00E9\u20DD"
let regionalIndicatorForUS:Character = "\U0001F1FA\U0001F1F8"


// Counting Characters
let unusualMenagerie = "Koala, Snail, penguin, Dromedary"
println("unusualMenagerie has \(countElements(unusualMenagerie)) characters")

// P.154
// Comparing Strings
let quotation = "We're a lot alike, you and I."
let sameQuotation = "We're a lot alike, you and I."
if quotation == sameQuotation {
    println("These two strings are considered equal")
}

// P.157
// Prefix and Suffix Equality
let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's masion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell",
]

var act1SceneCount = 0
for scene in romeoAndJuliet {
    if scene.hasPrefix("Act 1 ") {
        ++act1SceneCount
    }
}
println("There are \(act1SceneCount) scenes in Act 1")

var mansionCount = 0
var cellCount = 0
for scene in romeoAndJuliet {
    if scene.hasSuffix("Capulet's mansion") {
        ++mansionCount
    } else if scene.hasSuffix("Friar Lawrence's cell") {
        ++cellCount
    }
}
