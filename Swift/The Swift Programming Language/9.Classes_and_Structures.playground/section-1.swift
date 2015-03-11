
// P.346
// Classes and Structures

// Definition
struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

// Instances
let someResolution = Resolution()
let someVideoMode = VideoMode()

// Accessing Properties
println("The width of someResolution is \(someResolution.width)")
println("The width of someResolution is \(someVideoMode.resolution.width)")

someVideoMode.resolution.width = 1280

// Memberwise Initializers for Structure Types
let vga = Resolution(width: 640, height: 480)

// structures and Enumerations Are Value Types
var cinema = vga
cinema.width = 2048

// Classes Are Reference Types
let tenEighty = VideoMode()
tenEighty.resolution = cinema
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
println("The frameRate property of tenEighty is now \(tenEighty.frameRate)")

// Identity Operators
if tenEighty === alsoTenEighty {
    println("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}
