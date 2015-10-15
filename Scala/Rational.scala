implicit def intToRational(x: Int) = new Rational(x)

class Rational(n: Int, d: Int) {
   require(d != 0)
   private val g = gcd(n.abs, d.abs)
   val numer: Int = n / g
   val denom: Int = d / g

   private def gcd(a: Int, b: Int): Int = if (b == 0) a else gcd(b, a % b)

   override def toString = numer + "/" + denom

   def this(n: Int) = this(n, 1)

   def +(that: Rational) = new Rational(
      numer * that.denom + that.numer * denom,
      denom * that.denom
   )

   def +(i: Int) = new Rational(numer + i * denom, denom)

   def -(that: Rational) = new Rational(numer * that.denom - that.numer * denom, denom * that.denom)

   def -(i: Int) = new Rational(numer - i * denom, denom)

   def *(that: Rational) = new Rational(numer * that.numer, denom * that.denom)

   def *(i: Int) = new Rational(numer * i, denom)

   def /(that: Rational) = new Rational(numer * that.denom, denom * that.numer)

   def /(i: Int) = new Rational(numer, denom * i)

   def lessThan(that: Rational) = numer * that.denom < that.numer * denom

   def max(that: Rational) = if (lessThan(that)) that else this
}

// vim: set ts=4 sw=4 et:
