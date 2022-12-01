fs = require("fs");
const dingk = (data) => {
  const convertedStuff = data
    .split("\n\n")
    .map((i) => i.split(`\n`).map((i) => +i));

  console.log(
    Math.max(...convertedStuff.map((i) => i.reduce((a, b) => a + b, 0)))
  );
};

fs.readFile("input.txt", "utf8", function (err, data) {
  if (err) {
    return console.log(err);
  }
  dingk(data);
});
