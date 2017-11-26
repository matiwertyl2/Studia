var readline = require('readline');
var fs = require('fs');

function process_IP (path, n, callback) {
    var LineReader = readline.createInterface({
        input : fs.createReadStream(path)
    });

    var IP_requests= {};

    LineReader.on('line', function(line) {
        var arr = line.split(" ");
        if (IP_requests[arr[1]]) IP_requests[arr[1]]++;
        else (IP_requests[arr[1]]=1);
    });


    LineReader.on('close', function() {
        callback(IP_requests, n);
        process.exit();
    });
}

function process_IP_callback(IP_requests, n) {
    arr = [];
    for (x in IP_requests) arr.push([IP_requests[x], x]);
    arr.sort(function (a, b){
        if (a[0] > b[0]) return -1;
        if (a[0] < b[0]) return 1;
        return 0;
    });
    for (var i=0; i<n; i++) {
        if (arr.length > i) console.log(arr[i][1], " ", arr[i][0]);
    }
}

process_IP("zad7.txt", 3, process_IP_callback);


