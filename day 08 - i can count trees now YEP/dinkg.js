fs = require("fs");
const dingk = (data) => {
  const convertedStuff = data
    .split("\n")
    .filter((i) => i)
    .map((i) => i.split``.map((i) => +i));
  console.log(convertedStuff);

  // part one
  // let visibleTrees = new Set();

  // // from top to down
  // for (let i = 0; i < convertedStuff.length; i++) {
  //   let maxLineValue = Number.MIN_SAFE_INTEGER;
  //   for (let j = 0; j < convertedStuff.length; j++) {
  //     let value = convertedStuff[j][i];

  //     if (value > maxLineValue) {
  //       maxLineValue = value;
  //       visibleTrees.add([j, i].join(","));
  //     }
  //   }

  //   maxLineValue = Number.MIN_SAFE_INTEGER;
  //   for (let j = 0; j < convertedStuff.length; j++) {
  //     let value = convertedStuff[convertedStuff.length - 1 - j][i];

  //     if (value > maxLineValue) {
  //       maxLineValue = value;
  //       visibleTrees.add([convertedStuff.length - 1 - j, i].join(","));
  //     }
  //   }
  // }

  // // from left to right
  // convertedStuff.forEach((line, j) => {
  //   let maxLineValue = Number.MIN_SAFE_INTEGER;
  //   for (let i = 0; i < line.length; i++) {
  //     let value = line[i];
  //     if (value > maxLineValue) {
  //       maxLineValue = value;
  //       visibleTrees.add([j, i].join(","));
  //     }
  //   }
  // });

  // // from right to left
  // convertedStuff.forEach((line, j) => {
  //   let maxLineValue = Number.MIN_SAFE_INTEGER;
  //   for (let i = line.length - 1; i >= 0; i--) {
  //     let value = line[i];
  //     if (value > maxLineValue) {
  //       maxLineValue = value;
  //       visibleTrees.add([j, i].join(","));
  //     }
  //   }
  // });

  // // total visible trees?
  // console.log(visibleTrees.size);

  // part two
  let scenicScoresByCoord = new Map();

  // go through each thing
  convertedStuff.forEach((line, indexLine, fullarraybruh) => {
    line.forEach((item, index, ar) => {
      let scenicScore = 1;

      let left = (rigth = up = down = 0);

      // go left
      for (let i = index + 1; i < line.length; i++) {
        if (ar[i] < item) {
          left++;
        } else {
          left++;
          break;
        }
      }

      // go right
      for (let i = index - 1; i >= 0; i--) {
        if (ar[i] < item) {
          rigth++;
        } else {
          rigth++;
          break;
        }
      }

      // go down
      for (let i = indexLine + 1; i < line.length; i++) {
        if (fullarraybruh[i][index] < item) {
          down++;
        } else {
          down++;
          break;
        }
      }

      // go up
      for (let i = indexLine - 1; i >= 0; i--) {
        if (fullarraybruh[i][index] < item) {
          up++;
        } else {
          up++;
          break;
        }
      }

      scenicScore = up * down * rigth * left;

      scenicScoresByCoord.set(`${indexLine},${index}`, scenicScore);
    });
  });

  console.log(Math.max(...scenicScoresByCoord.values()));
};

fs.readFile("input.txt", "utf8", function (err, data) {
  if (err) {
    return console.log(err);
  }
  dingk(data);
});
