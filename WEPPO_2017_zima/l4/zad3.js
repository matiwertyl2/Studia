function Foo (e) {
    var x = e;

    var Qux = function () {
        return x;
    }

    this.Bar = function () {
        return Qux();
    }
} 

var f = new Foo (2);

console.log(f.Bar());
//console.log(f.Qux());
console.log(f.x);