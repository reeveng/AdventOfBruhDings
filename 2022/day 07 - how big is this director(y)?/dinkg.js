fs = require("fs");
const dingk = (data) => {
  const convertedStuff = data
    .split("\n")
    .filter((i) => i)
    .map((i) => i.split` `);

  // structure == "/"
  let structure = {};
  let currentPath = "";

  // part one
  // convertedStuff.map((i) => {
  //   // its a command
  //   if (i[0] == "$") {
  //     if (i[1] == "cd" && i[2] != "..") {
  //       currentPath += i[2];
  //       currentPath += "/";
  //       currentPath = currentPath.replace(/\/\//g, "/");
  //       structure[currentPath] = {};
  //     } else if (i[1] == "cd" && i[2] == "..") {
  //       currentPath = currentPath.replace(/[^\/]+\/$/, "");
  //     }
  //   }
  //   // its something else
  //   else if (+i[0] == i[0]) {
  //     let changedPath = currentPath;
  //     do {
  //       structure[changedPath][i[1]] = +i[0];

  //       changedPath = changedPath.replace(/([^\/]+)?\/$/, "");
  //     } while (changedPath);

  //     // for all upper directories add it to the upper directory =>
  //     // convert path to thing as long as path is able to be converted
  //   }
  // });

  // console.log(
  //   Object.values(structure)
  //     .map((i) => Object.values(i).reduce((a, b) => a + b, 0))
  //     .filter((i) => i <= 100000)
  //     .reduce((a, b) => a + b, 0)
  // );

  // part two
  convertedStuff.map((i) => {
    // its a command
    if (i[0] == "$") {
      if (i[1] == "cd" && i[2] != "..") {
        currentPath += i[2];
        currentPath += "/";
        currentPath = currentPath.replace(/\/\//g, "/");
        structure[currentPath] = {};
      } else if (i[1] == "cd" && i[2] == "..") {
        currentPath = currentPath.replace(/[^\/]+\/$/, "");
      }
    }
    // its something else
    else if (+i[0] == i[0]) {
      let changedPath = currentPath;
      do {
        // add to structure
        if (structure[changedPath][i[1]]) {
          structure[changedPath][i[1]] += +i[0];
        } else {
          structure[changedPath][i[1]] = +i[0];
        }

        changedPath = changedPath.replace(/([^\/]+)?\/$/, "");
      } while (changedPath);

      // for all upper directories add it to the upper directory =>
      // convert path to thing as long as path is able to be converted
    }
  });

  // console.log(structure);

  const sortedValues = Object.values(structure)
    .map((i) => Object.values(i).reduce((a, b) => a + b, 0))
    .sort((a, b) => b - a);

  let unusedspace = 70000000 - sortedValues[0];

  console.log(
    sortedValues
      .filter((i) => i >= Math.abs(unusedspace - 30000000))
      .sort((a, b) => a - b)[0]
  );
};

fs.readFile("input.txt", "utf8", function (err, data) {
  if (err) {
    return console.log(err);
  }
  dingk(data);
});
