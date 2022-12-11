fs = require("fs");
const dingk = (data) => {
  let counter = 0;
  const convertedStuff = [];
  data
    .split("\n")
    .filter((i) => i)
    .map((i) => {
      if (i.toLowerCase().includes("monkey")) {
        counter++;
        convertedStuff.push({});
      }
      if (i.toLowerCase().includes("starting items")) {
        convertedStuff[counter - 1].items = i
          .split(":")[1]
          .trim()
          .split(", ")
          .map((i) => +i);
      }
      if (i.toLowerCase().includes("operation")) {
        convertedStuff[counter - 1].operation = i.split(":")[1].trim();
      }
      if (i.toLowerCase().includes("operation")) {
        convertedStuff[counter - 1].test = i.split(":")[1].trim();
      }
    });
  console.log(convertedStuff, data);

  // part one
  for (let i = 0; i < 20; i++) {}

  // part two
};

fs.readFile("input.txt", "utf8", function (err, data) {
  if (err) {
    return console.log(err);
  }
  dingk(data);
});
