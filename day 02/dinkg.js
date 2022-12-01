fs = require("fs");
const dingk = (data) => {
  const convertedStuff = data
    .split("\n\n")
    .map((i) => i.split(`\n`).map((i) => +i));

  // part one
  console.log();

  // part two
  console.log();
};

fs.readFile("input.txt", "utf8", function (err, data) {
  if (err) {
    return console.log(err);
  }
  dingk(data);
});
