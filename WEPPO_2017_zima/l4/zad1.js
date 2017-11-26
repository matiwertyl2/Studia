function Tree(L, R, value) {
    this.val = value;
    this.L = L;
    this.R = R;
}

Tree.prototype[Symbol.iterator] = function* () {
    if (this.L) {
        for (x of this.L)  yield x;
    }
    yield this.val;
    if (this.R) {
        for (x of this.R) yield x;
    }
}

function Full_Tree(depth, x) {
    if (depth == 0) return new Tree(null, null, x);
    var s = Math.pow(2, depth) -1;
    var lx = x - (s-1)/2 -1;
    var rx = x + (s-1)/2 +1;
    var L = Full_Tree(depth-1, lx);
    var R = Full_Tree(depth-1, rx);
    return new Tree(L, R, x);
}

function FullTree(depth) {
    return Full_Tree(depth, Math.pow(2, depth));
}


var tree = FullTree(3);

for (x of tree) console.log(x);


