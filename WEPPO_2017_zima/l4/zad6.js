var fs = require('fs');
var util = require('util');

fs.readFile("zad6.txt", {encoding: 'utf8'}, 
    (err, data) => {
        console.log(data)
    });


var readFileAsync = util.promisify(fs.readFile);

(async function () {
    var d = await readFileAsync("zad6.txt", {encoding : "utf8"});
    console.log("ASYNC");
    console.log(d);
})();

