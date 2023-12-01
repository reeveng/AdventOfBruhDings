fs = require("fs");
const dingk = (data) => {
  const convertedStuff = data
    .split("\n")
    .filter((i) => i)
    .map((i) => i.split`,`.map((j) => j.split`-`.map((r) => +r)));

  // part one
  // console.log(
  //   convertedStuff.filter(([a, b]) => {
  //     [x, y] = a;
  //     [q, p] = b;
  //     console.log(x, y, q, p);
  //     if ((x > q && y > p) || (x < q && y < p)) {
  //       return true;
  //     }
  //     return false;
  //   })
  // );

  // part two
  console.log(
    convertedStuff.filter(([a, b]) => {
      [x, y] = a;
      [q, p] = b;

      [e, f, h, g] = [...a, ...b].sort((a, b) => a - b);
      return !(
        ((e == x && f == y && q == h && p == g) ||
          (x == h && y == g && q == e && p == f)) &&
        f != h
      );
    }).length
  );
};

fs.readFile("input.txt", "utf8", function (err, data) {
  if (err) {
    return console.log(err);
  }
  dingk(data);
});
