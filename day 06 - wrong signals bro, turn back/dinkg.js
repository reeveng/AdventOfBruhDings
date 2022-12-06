fs = require("fs");
const dingk = (data) => {
  const convertedStuff = data
    .split("\n")
    .filter((i) => i)
    .map((i) => i);

  // part one
  // const dingk = convertedStuff.map((k) =>
  //   k.split``.findIndex((i, j, a) => {
  //     const ding = {};
  //     return (
  //       a
  //         .slice(j, j + 4)
  //         .map((i) => {
  //           ding[i] ? (ding[i] += 1) : (ding[i] = 1);
  //           return ding[i];
  //         })
  //         .filter((i) => i != 1).length === 0
  //     );
  //   })
  // );
  // console.log(dingk.map((i) => i + 4));

  // part two
  const dingk = convertedStuff.map((k) =>
    k.split``.findIndex((i, j, a) => {
      const ding = {};
      return (
        a
          .slice(j, j + 14)
          .map((i) => {
            ding[i] ? (ding[i] += 1) : (ding[i] = 1);
            return ding[i];
          })
          .filter((i) => i != 1).length === 0
      );
    })
  );
  console.log(dingk.map((i) => i + 14));
};

fs.readFile("input.txt", "utf8", function (err, data) {
  if (err) {
    return console.log(err);
  }
  dingk(data);
});
