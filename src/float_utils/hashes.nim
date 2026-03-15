
import std/hashes; export Hash
from ./isX import isfinite, isinf, isnan
from std/math import frexp

const PyHASH_BITS* = when sizeof(pointer) >= 8: 61 else: 31
const PyHASH_MODULUS* = (1u shl PyHASH_BITS) - 1

const PyHASH_INF* = 314159
  
type
  Py_uhash_t = uint
static: assert sizeof(Py_uhash_t) == sizeof(Hash)


proc Py_HashDouble*(v: float): Hash =
  ## `_Py_HashDouble`
  if not isfinite(v):
    if isinf(v):
      return if v > 0.0: PyHASH_INF else: -PyHASH_INF
    else:
      raise newException(ValueError, "cannot hash NaN")
  
  var (m, e) = frexp(v)

  var sign = true
  if m < 0.0:
    sign = false
    m = -m

  var x: Py_uhash_t = 0
  var y: Py_uhash_t

  while m != 0.0:
    x = ((x shl 28) and PyHASH_MODULUS) or (x shr (PyHASH_BITS - 28))
    m *= 268435456.0 # 2**28
    e -= 28
    y = Py_uhash_t(m)
    m -= float(y)
    x += y
    if x >= PyHASH_MODULUS:
      x -= PyHASH_MODULUS

  # adjust for the exponent; first reduce it modulo PyHASH_BITS
  e = if e >= 0:
    e mod PyHASH_BITS
  else:
    PyHASH_BITS - 1 - ((-1 - e) mod PyHASH_BITS)
  x = ((x shl e) and PyHASH_MODULUS) or (x shr (PyHASH_BITS - e))

  x = x * Py_uhash_t(sign)
  if x == Py_uhash_t.high:
    x = cast[Py_uhash_t](-2)
  return Hash x

proc hash*(v: float): Hash = Py_HashDouble(v)
