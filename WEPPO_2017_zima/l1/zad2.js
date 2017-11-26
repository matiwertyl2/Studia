function digitSum(x) 
{
    var res = 0;
    while (x != 0) {
        res += x % 10;
        var x = Math.floor ( x / 10);
    }
    return res;
} 

function isDivisible( n, divisors) 
{
    for ( var i = 0; i< divisors.length; i++) {
        if (n % divisors[i] != 0) return false;
    }
    return true;
}

function createDivisors( n)
{
    var res =[];
    while (n!=0) 
    {
        var x = n % 10;
        if (x != 0) res.push(x);
        n = Math.floor(n/10);
    }
    return res;
}

function isGoodNumber( n) {
    var divisors = [digitSum(n)].concat(createDivisors(n));
    return isDivisible(n, divisors);
}

function findGoodNumbers(beg, end) 
{
    var numbers=[];
    for (var i = beg; i<= end; i++) 
    {
        if (isGoodNumber(i)) numbers.push(i);
    }
    return numbers;
}

console.log(findGoodNumbers(1, 100000));