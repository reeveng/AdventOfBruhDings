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
  // console.log(convertedStuff);
  let x = 1;

  // get sum of signal strengths
  // signal strength = cycle*X
  // part one
  // let totalSignalStrength = 0;
  // let cycle = 1;

  // convertedStuff.forEach((signal) => {
  //   [length, command, value] = signal;

  //   for (let i = 0; i < length; i++) {
  //     if ((cycle - 20) % 40 == 0) {
  //       totalSignalStrength += x * cycle;
  //     }
  //     cycle++;
  //   }
  //   if (length == 2) {
  //     x += value;
  //   }
  // });

  // console.log(cycle);
  // console.log(totalSignalStrength);

  // create sprite stuff
  // width of sprite is 3
  // hmm other important info
  // part two
  let cycle = 0;
  let dingk = "";

  convertedStuff.forEach((signal) => {
    const [length, command, value] = signal;

    for (let i = 0; i < length; i++) {
      if (x - 1 <= cycle % 40 && cycle % 40 <= x + 1) {
        dingk += "#";
      } else {
        dingk += ".";
      }
      if ((cycle + 1) % 40 == 0) {
        dingk += "\n";
      }
      cycle++;
    }
    if (length == 2) {
      x += value;
    }
  });

  console.log(dingk);
};

fs.readFile("input.txt", "utf8", function (err, data) {
  if (err) {
    return console.log(err);
  }
  dingk(data);
});
