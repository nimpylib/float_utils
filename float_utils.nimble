# Package

version       = "0.1.1"
author        = "litlighilit"
description   = "utils/functions about float, used by nimpylib"
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 2.0.10"

var pylibPre = "https://github.com/nimpylib"
let envVal = getEnv("NIMPYLIB_PKGS_BARE_PREFIX")
if envVal != "": pylibPre = ""
#if pylibPre == Def: pylibPre = ""
elif pylibPre[^1] != '/':
  pylibPre.add '/'
template pylibOf(x, ver): string =
  if pylibPre == "": x & ver
  else: pylibPre & x
template pylib(x, ver) =
  requires pylibOf(x, ver)
pylib "nimpatch", " ^= 0.1.1"
pylib "handy_sugars", " ^= 0.1.0"
pylib "unicode_space_decimal", " ^= 0.1.0"
pylib "pymath", " ^= 0.1.0"
pylib "pyround", " ^= 0.1.0"
pylib "pysimperr", " ^= 0.1.0"

taskRequires "test", pylibOf("pyunittest", " ^= 0.1.0")

