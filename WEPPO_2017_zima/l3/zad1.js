function person(height, weight) {
    var _weight = weight;
    this.height=height;

    Object.defineProperty(this, "weight", {
        get : function() {
            return _weight;
        },
        set : function(value) {
            _weight = value;
        }
    })

}

var jan = new person(1.78, 75);
jan._bmi = jan.weight / (jan.height * jan.height);
Object.defineProperty(jan, "bmi", {
    get : function () {
        return jan._bmi;
    },
    set : function(value) {
        jan._bmi = value;
    }
})
console.log(jan.bmi);
console.log(jan._bmi);