import Foundation

Welcome()

var prompt: String = ">"
if Process.arguments.count >= 2 {
   prompt = Process.arguments[1]
}

print("\(prompt) ", terminator:"")
var input: String = ""
while true {
	let c = Character(UnicodeScalar(UInt32(fgetc(stdin))))
	if c == "\n" {
		if input == "quit" {
			exit(0)
		} else {
			print(input)
		}
		input = ""
		print("\(prompt) ", terminator:"")
	} else {
		input.append(c)
	}
}