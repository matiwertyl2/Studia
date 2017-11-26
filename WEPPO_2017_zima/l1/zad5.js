function recursiveFib( n ) 
{
    if (n <= 1) return 1;
    return recursiveFib(n-1) + recursiveFib(n-2);
}

function iterateFib( n )
{
    f1=1;
    f2=0;
    for (var i = 1; i<=n; i++) 
    {
        var f = f1 + f2;
        f2 = f1;
        f1 = f;
    }
    return f1;
}

for (var i = 10; i<=45; i++) 
{
    console.log("N = ", i);
    console.time("Recursive");
    var r1 = recursiveFib(i);
    var t = console.timeEnd("Recursive");
    console.time("Iterable")
    var r2 = iterateFib(i);
    console.timeEnd("Iterable");
}

/*
for (var i = 10; i<=45; i++) 
{
    console.log("N = ", i);
    var start = new Date().getTime();
    var r1 = recursiveFib(i);
    var end = new Date().getTime();
    console.log("Recursive: ", end-start);
    start = new Date().getTime();
    var r1 = iterateFib(i);
    end = new Date().getTime();
    console.log("Iterable: ", end-start);
}
*/