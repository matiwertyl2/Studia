var arr= [1, 2, 3, 4];

function forEach (arr, f) {
    for (var i =0; i<arr.length; i++) f(arr[i]);
}

function filter(arr, f) {
    res =[];
    for (var i =0; i<arr.length; i++) {
        if (f(arr[i])) res.push(arr[i]);
    }
    return res;
}

function filter2(arr, f) {
    for (var i=0; i<arr.length; i++) {
        if (f(arr[i]) == false ) {
            arr.splice(i, 1);
            i--;
        }
    }
}

function map(arr, f) {
    res = [];
    for (var i = 0; i<arr.length; i++) {
        res.push(f(arr[i]));
    }
    return res;
}

function printElm(n) {
    console.log("element " , n);
}

forEach(arr, printElm);
console.log(filter(arr, _ => _ < 3));
console.log(map(arr, function (x) { return x*2}));
filter2(arr, _ => _ < 3);
console.log(arr);