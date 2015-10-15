def plainOldSum(x: Int, y: Int) = x + y
def curriedSum(x: Int)(y: Int) = x + y

plainOldSum(1,2)
curriedSum(1)(2)

val onePlus = curriedSum(1)_
onePlus(2)

// vim: set ts=4 sw=4 et:
