var F = require("./mod4")

var foo = F.comp(F.f, F.g);

console.log(foo(10));
