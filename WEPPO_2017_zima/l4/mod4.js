function f(x) {
    return x*x;
}

function g(x) {
    return x-1;
}

function comp(f, g) {
    return function (x) {
        return f(g(x));
    }
}

module.exports = {
    f : f, 
    g : g,
    comp : comp
}