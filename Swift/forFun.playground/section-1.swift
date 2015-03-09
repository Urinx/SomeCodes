
/*
 The first easy Swift program
 I finally get it, WTF.. T_T..
*/
import Cocoa
typealias 😁=Int[]
var 🐶:😁=[],💔=0,💪=1,😭=10
for _ in 💔..😭{🐶+=Int(arc4random()%100)}

func 😱(😂:😁)->😁
{
    var 😰=😂.count,🈲:😁=[],💯:😁=[]
    if 😰<=💪 {return 😂}

    for 😙 in 😂[💪..😰]
    {
        if 😙<😂[💔] {🈲+=😙}
        else {💯+=😙}
    }
    return 😱(🈲)+[😂[💔]]+😱(💯)
}
😱(🐶)