function createFS(n) {
    var fs = [];

    var _loop = function _loop(i) {
        fs[i] = function () { return i; }
    }
    for (var i =0; i<n; i++) {
     _loop(i); // teraz i jest lokalne 
    }
    return fs;
  }
  
  var myfs = createFS(10);
  console.log(myfs[0]());
  console.log(myfs[5]());
  console.log(myfs[9]());

