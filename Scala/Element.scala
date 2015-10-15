abstract class Element {
   def contents: Array[String]
   def height: Int = contents.length
   def width: Int = if (height == 0) 0 else contents(0).length
}

class ArrayElement(conts: Array[String]) extends Element {
   def contents: Array[String] = conts
}

// vim: set ts=4 sw=4 et:
