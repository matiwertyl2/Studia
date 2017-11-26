var memo_fib = (function() {
    var memo = {};
  
    function f(n) {
      var value;
  
      if (n in memo) {
        value = memo[n];
      } 
      else {
        if (n == 0 || n == 1)
          value = n;
        else
          value = f(n - 1) + f(n - 2);
  
        memo[n] = value;
      }
      return value;
    }

    return f;
})();


function fib(n) {
    if (n == 0 || n == 1) return n;
    return fib(n-1) + fib(n-2);
}

var n = 40;
console.time("memo_fib");
var f1 = memo_fib(n);
console.timeEnd("memo_fib");
console.time("fib")
var f2 = fib(n);
console.timeEnd("fib");
