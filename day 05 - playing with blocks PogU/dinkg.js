fs = require("fs");
const dingk = (data) => {
  /**
    [D]
[N] [C]
[Z] [M] [P]

   */
  // const bruh = ["ZN", "MCD", "P"];
  /*
                [V]     [C]     [M]
[V]     [J]     [N]     [H]     [V]
[R] [F] [N]     [W]     [Z]     [N]
[H] [R] [D]     [Q] [M] [L]     [B]
[B] [C] [H] [V] [R] [C] [G]     [R]
[G] [G] [F] [S] [D] [H] [B] [R] [S]
[D] [N] [S] [D] [H] [G] [J] [J] [G]
[W] [J] [L] [J] [S] [P] [F] [S] [L]
 1   2   3   4   5   6   7   8   9
*/
  const bruh = [
    "WDGBHRV",
    "JNGCRF",
    "LSFHDNJ",
    "JDSV",
    "SHDRQWNV",
    "PGHCM",
    "FJBGLZHC",
    "SJR",
    "LGSRBNVM",
  ];

  /**
move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
   */
  const convertedStuff = data
    .split("\n")
    .filter((i) => i)
    .map((i) =>
      i.replace(/[a-z]/gi, "").split` `.filter((i) => i).map((i) => +i)
    );

  // part one
  // convertedStuff.forEach((move_from_to) => {
  // console.log(bruh.map((i) => i));

  //   let [move, from, to] = move_from_to;
  //   from -= 1;
  //   to -= 1;
  //   const stringPartToMove = bruh[from].substring(
  //     bruh[from].length - move,
  //     bruh[from].length
  //   );
  //   bruh[from] = bruh[from].substring(0, bruh[from].length - move);

  //   bruh[to] = bruh[to] + stringPartToMove.split``.reverse().join``;
  // });

  // console.log(bruh.map((i) => i[i.length-1]).join``);

  // part two
  convertedStuff.forEach((move_from_to) => {
    console.log(bruh.map((i) => i));

    let [move, from, to] = move_from_to;
    from -= 1;
    to -= 1;
    const stringPartToMove = bruh[from].substring(
      bruh[from].length - move,
      bruh[from].length
    );
    bruh[from] = bruh[from].substring(0, bruh[from].length - move);

    bruh[to] = bruh[to] + stringPartToMove;
  });

  console.log(bruh.map((i) => i[i.length - 1]).join``);
};

fs.readFile("input.txt", "utf8", function (err, data) {
  if (err) {
    return console.log(err);
  }
  dingk(data);
});
