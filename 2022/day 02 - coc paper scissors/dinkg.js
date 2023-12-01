fs = require("fs");
const dingk = (data) => {
  /**
   * oppchoicefor Rock, mechoice for Paper, and C for Scissors
   * X for Rock, Y for Paper, and Z for Scissors
   *
   * (1 for Rock, 2 for Paper, and 3 for Scissors)
   * plus the score for the outcome of the round
   * (0 if you lost, 3 if the round was oppchoicedraw, and 6 if you won)
   */
  let opponent = 0,
    me = 0;

  const convertedStuff = data.split("\n").map((i) => i.split(` `));

  // part one
  convertedStuff.map(([oppchoice, mechoice]) => {
    switch (mechoice) {
      case "Y": // paper
        switch (oppchoice) {
          case "B": // paper
            opponent += 3 + 2;
            me += 3 + 2;
            break;
          case "A": // rock
            me += 6 + 2;
            opponent += 0 + 1;
            break;
          case "C": // scissors
            me += 0 + 2;
            opponent += 6 + 3;
            break;
        }
        break;
      case "X": // rock
        switch (oppchoice) {
          case "B": // paper
            opponent += 6 + 2;
            me += 0 + 1;
            break;
          case "A": // rock
            me += 3 + 1;
            opponent += 3 + 1;
            break;
          case "C": // scissors
            me += 6 + 1;
            opponent += 0 + 3;
            break;
        }
        break;
      case "Z": // scissors
        switch (oppchoice) {
          case "B": // paper
            opponent += 0 + 2;
            me += 6 + 3;
            break;
          case "A": // rock
            me += 0 + 3;
            opponent += 6 + 1;
            break;
          case "C": // scissors
            me += 3 + 3;
            opponent += 3 + 3;
            break;
        }
        break;
    }
  });

  (opponent = 0), (me = 0);
  // part two
  /**
   * X means you need to lose,
   * Y means you need to end the round in a draw, and
   * Z means you need to win
   */
  convertedStuff.map(([oppchoice, mechoice]) => {
    switch (mechoice) {
      case "Y": // draw
        switch (oppchoice) {
          case "B": // paper
            opponent += 3 + 2;
            me += 3 + 2;
            break;
          case "A": // rock
            opponent += 3 + 1;
            me += 3 + 1;
            break;
          case "C": // scissors
            opponent += 3 + 3;
            me += 3 + 3;
            break;
        }
        break;
      case "X": // lose
        switch (oppchoice) {
          case "B": // paper
            opponent += 6 + 2;
            me += 0 + 1;
            break;
          case "A": // rock
            me += 0 + 3;
            opponent += 3 + 1;
            break;
          case "C": // scissors
            me += 0 + 2;
            opponent += 0 + 3;
            break;
        }
        break;
      case "Z": // win
        switch (oppchoice) {
          case "B": // paper
            opponent += 0 + 2;
            me += 6 + 3;
            break;
          case "A": // rock
            me += 6 + 2;
            opponent += 6 + 1;
            break;
          case "C": // scissors
            me += 6 + 1;
            opponent += 3 + 3;
            break;
        }
        break;
    }
  });
  console.log({ opponent }, { me });
};

fs.readFile("input.txt", "utf8", function (err, data) {
  if (err) {
    return console.log(err);
  }
  dingk(data);
});
