def withPrintWrite(file: File)(op: PrintWrite => Unit) {
   val writer = new PrintWriter(file)
   try {
      op(writer)
   } finally {
      writer.close()
   }
}

val file = new File("date.txt")
withPrintWriter(file) {
   writer => writer.println(new java.util.Date)
}

// vim: set ts=4 sw=4 et:
