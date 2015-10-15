def echo(args:String*) = args.foreach(println)

echo("123", "wdewf")

val arr = Array("aaa", "bbb", "ccc")
echo(arr: _*)

// vim: set ts=4 sw=4 et:
