/*const readline = require('readline');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

rl.question('Jak masz na imię ? ', (answer) => {
  console.log(`Witaj, ${answer}`);
  rl.close();
}); */

process.stdin.setEncoding('utf8');

console.log("Jak masz na imię?");
process.stdin.on('readable', function () {
  var name = process.stdin.read();
  if (name !== null) {
    process.stdout.write(`Witaj, ${name}`);
    process.exit();
  }
});
