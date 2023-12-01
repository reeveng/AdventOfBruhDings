fs = require("fs");
const dingk = (data) => {
  // const convertedStuff = data
  //   .split("\n")
  //   .map((i) =>
  //     i.substring(0, i.length / 2).split``.filter((j) =>
  //       i.substring(i.length / 2, i.length).includes(j)
  //     )
  //   );

  // part one
  // console.log(
  //   convertedStuff
  //     .map((i) => i[0])
  //     .filter((i) => i)
  //     .map((i) =>
  //       i.toUpperCase() == i
  //         ? i.charCodeAt() - "A".charCodeAt() + 27
  //         : i.charCodeAt() - "a".charCodeAt() + 1
  //     )
  //     .reduce((a, b) => a + b, 0)
  // );

  // part two
  const dingk = [];

  const convertedStuff = data.split("\n").filter((i) => i);
  let j = 0;
  for (let i = 0; i < convertedStuff.length; i++) {
    if (i % 3 == 0) {
      j++;
    }
    if (!dingk[j]) {
      dingk[j] = [];
    }
    dingk[j].push(convertedStuff[i]);
  }

  console.log(
    dingk
      .map(([a, b, c]) => {
        return a.split``.find((i) => b.includes(i) && c.includes(i));
      })
      .map((i) =>
        i.toUpperCase() == i
          ? i.charCodeAt() - "A".charCodeAt() + 27
          : i.charCodeAt() - "a".charCodeAt() + 1
      )
      .reduce((a, b) => a + b, 0)
  );
};

fs.readFile("input.txt", "utf8", function (err, data) {
  if (err) {
    return console.log(err);
  }
  dingk(data);
});
