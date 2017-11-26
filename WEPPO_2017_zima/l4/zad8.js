var fs = require('fs');
var util = require('util');

function readFilePromise(path) {
    return new Promise(
        function (res, rej) {
            fs.readFile(path, function(err, data){
                if (err) rej(err);
                res(data.toString());
            });
        }
    );
}

readFilePromise("zad6.txt")
    .then( function(data){
        console.log(data);
    });

var readFileAsync = util.promisify(fs.readFile);

(async function() {
    var data = await readFileAsync("zad6.txt", {encoding : 'utf8'});
    console.log(data);
}
)();