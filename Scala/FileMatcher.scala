object FileMatcher {
   private def filesHere = (new java.io.File(".")).listFiles
   private def filesMatching(matcher: String => Boolean) = {
      filesHere.filter(file => matcher(file.getName))
   }
   def filesEnding(query: String) = filesMatching(_.endsWith(query))
   def filesContaining(query: String) = filesMatching(_.contains(query))
   def filesRegex(query: String) = filesMatching(_.matches(query))
}

FileMatcher.filesEnding("scala").foreach(println)

// vim: set ts=4 sw=4 et:
