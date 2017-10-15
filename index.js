var binwrap = require("binwrap");
var path = require("path");

var packageInfo = require(path.join(__dirname, "package.json"));
var root = "https://github.com/andys8/translate-cli/raw/master/bin/";

module.exports = binwrap({
  binaries: [
      "translate"
    ],
  urls: {
      "darwin-x64": root + "x86_64-osx/translate.tgz",
      "linux-x64": root + "x86_64-linux/translate.tgz",
    }
});
