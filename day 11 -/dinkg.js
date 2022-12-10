fs = require("fs");
const dingk = (data) => {
  const convertedStuff = data
    .split("\n")
    .filter((i) => i)
    .map((i) => {
      let ding = i.split(" ");
      if (ding.length == 2) {
        let [a, b] = ding;
        return [ding.length, a, +b];
      }
      return [ding.length, ...ding];
    });
  console.log(convertedStuff);

  // part one

  // part two
};

fs.readFile("input.txt", "utf8", function (err, data) {
  if (err) {
    return console.log(err);
  }
  dingk(data);
});
