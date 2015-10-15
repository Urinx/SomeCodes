import scala.io.Source

if (args.length > 0) {
   val lines = Source.fromFile(args(0)).getLines.toList
   val longestLine = lines.reduceLeft(
      (a, b) => if (a.length > b.length) a else b
   )
   val maxWidth = longestLine.length.toString.length
   for (line <- lines) {
      val numSpaces = maxWidth - line.length.toString.length
      val padding = " " * numSpaces
      println(padding + line.length + " | " + line)
   }
}
else Console.err.println("Please enter filename")

// vim: set ts=4 sw=4 et:
