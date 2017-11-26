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

function* take(it, top) {
    var index =0;
    while (index < top) {
        index++;
        yield it.next().value;
    }
}

for (f of take(fib(), 10)) {
    console.log(f);
}