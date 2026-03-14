# Package

version       = "0.1.0"
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
template pylib(x, ver) =
  requires if pylibPre == "": x & ver
           else: pylibPre & x
pylib "dtoa_c", " ^= 0.1.0"
pylib "autoconf_sugars", " ^= 0.1.0"
pylib "errno", " ^= 0.1.0"

