fs = require("fs");
const dingk = (data) => {
  const convertedStuff = data
    .split("\n\n")
    .map((i) => i.split(`\n`).map((i) => +i));

  // part one
  console.log(
    Math.max(...convertedStuff.map((i) => i.reduce((a, b) => a + b, 0)))
  );

  // part two
  console.log(
    convertedStuff
      .map((i) => i.reduce((a, b) => a + b, 0))
      .sort((a, b) => b - a)
  );

  console.log(71300 + 69249 + 69142);
};

fs.readFile("input.txt", "utf8", function (err, data) {
  if (err) {
    return console.log(err);
  }
  dingk(data);
});
