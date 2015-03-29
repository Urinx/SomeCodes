// online exam
(function(){
    var n = 0;
    const maxNum = 2;
    window.addEventListener('focus', e => {
        n++ && alert(`你已离开本页面${n}次，最多只能${maxNum}次哦`);
        if (n >= maxNum) {
            self.removeEventListener(e.type, arguments.callee, false);

            fetch('/api/cheat', {
                method: 'POST',
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: "id=123456&score=0"
            }).then(r => {
                if (r.ok) alert('经发现，该同学存在作弊行为，已取消考试资格，本次成绩记为0');
            })
        }
    }, false);
})()