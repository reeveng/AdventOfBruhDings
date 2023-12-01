fs = require("fs");
const dingk = (data) => {
  const convertedStuff = data
    .split("\n")
    .filter((i) => i)
    .map((i) => {
      [a, b] = i.split` `;
      return [a, +b];
    });

  // part one
  // let posXT = 0;
  // let posYT = 0;
  // let posXH = 0;
  // let posYH = 0;

  // const allVisited = new Set();
  // allVisited.add("0,0");

  // for (let item of convertedStuff) {
  //   let [direction, nrOfMoves] = item;
  //   for (let i = 0; i < nrOfMoves; i++) {
  //     let previousPos = [posXH, posYH];
  //     switch (direction) {
  //       case "R":
  //         posXH += 1;
  //         break;
  //       case "L":
  //         posXH -= 1;
  //         break;
  //       case "U":
  //         posYH += 1;
  //         break;
  //       case "D":
  //         posYH -= 1;
  //         break;
  //     }

  //     if (
  //       posXH != posXT &&
  //       posYT != posYH &&
  //       Math.abs(posXH - posXT) - Math.abs(posYH - posYT) != 0
  //     ) {
  //       [posXT, posYT] = previousPos;
  //     }
  //     if (Math.abs(posXH - posXT) == 2 || Math.abs(posYH - posYT) == 2) {
  //       [posXT, posYT] = previousPos;
  //     }

  //     allVisited.add([posXT, posYT].join`,`);
  //   }
  // }

  // let ding = [1, 2, 3, 4, 5, 6].map((i) => ".".repeat(5).split``);
  // [...allVisited].forEach((i) => {
  //   [x, y] = i.split`,`;
  //   ding[x][y] = "#";
  // });
  // console.log(ding);

  // console.log(allVisited.size);

  // part two, doesn't work but answer is 2630

  let items = [...["H", 2, 3, 4, 5, 6, 7, 8, 9, "T"].map((i) => [0, 0])];

  const allVisited = new Set();
  allVisited.add("0,0");

  console.log(items);

  for (let item of convertedStuff) {
    let [direction, nrOfMoves] = item;
    for (let i = 0; i < nrOfMoves; i++) {
      let dingstoupdate = items;
      switch (direction) {
        case "R":
          items[0][0] += 1;
          break;
        case "L":
          items[0][0] -= 1;
          break;
        case "U":
          items[0][1] += 1;
          break;
        case "D":
          items[0][1] -= 1;
          break;
      }

      const bruh = [];

      items.forEach((item, index, arr) => {
        let [posXT, posYT] = item;

        if (index != 0) {
          let [posXH, posYH] = arr[index - 1];
          let previousPos = dingstoupdate[index - 1];

          if (
            posXH != posXT &&
            posYT != posYH &&
            Math.abs(posXH - posXT) - Math.abs(posYH - posYT) != 0
          ) {
            [posXT, posYT] = previousPos;
          }
          if (Math.abs(posXH - posXT) == 2 || Math.abs(posYH - posYT) == 2) {
            [posXT, posYT] = previousPos;
          }
        }

        bruh.push([posXT, posYT]);
      });

      items = bruh;

      allVisited.add(items[items.length - 1].join`,`);
    }
  }

  console.log(items);
};

fs.readFile("input.txt", "utf8", function (err, data) {
  if (err) {
    return console.log(err);
  }
  dingk(data);
});
