function fib() {
    var f0=0;
    var f1=1;
    var index = 0;

    return {
        next : function() {
            return {
                value : (function () {
                    if (index < 2) {
                        return index++;
                    }
                    var f = f0+f1;
                    f0=f1;
                    f1 =f;
                    return f;
                })(), 
                done : false

            }
        }
    }
}

function *fib () {
    var f0 =0;
    var f1 = 1;
    var index = 0;
    while (true) {
        if (index == 0 || index == 1) {
            yield index++;
        }
        else {
            var f = f0+f1;
            f0=f1;
            f1 = f;
            yield f;
        }
    }
} 

var _it = fib();

for ( var res; res =_it.next(), !res.done;) {
    if (res.value > 1000) break;
    console.log(res.value);
}

for (f of fib()) {
    if (f > 20) break;
    console.log(f);
}
