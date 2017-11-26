function primeNumbers ( n) 
{
    var isPrime = [];
    for ( var i = 0; i <= n; i++) isPrime.push(true);
    var jump = 2;
    while (jump * jump <= n) 
    {
        for (var i=jump*jump; i<=n; i+=jump)
        {
            isPrime[i] = false;
        }
        jump++;
        while (jump <= n && isPrime[jump] == false) jump++;
    } 
    var primes = [];
    for ( var i = 2; i<=n; i++) 
    {
        if (isPrime[i]) primes.push(i);
    }
    return primes;
}

console.log(primeNumbers(100000));