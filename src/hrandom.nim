# This is just an example to get you started. A typical library package
# exports the main API in this file. Note that you cannot rename this file
# but you can remove it if you wish.

type
  XorShift* = ref object
    x: uint64

proc init*(seed: uint64): XorShift =
  XorShift(x: seed)

proc rand*(obj: XorShift): (uint64, XorShift) =
  var nextObj = obj
  nextObj.x = nextObj.x xor (nextObj.x shl 13)
  nextObj.x = nextObj.x xor (nextObj.x shr 7)
  nextObj.x = nextObj.x xor (nextObj.x shl 17)
  (nextObj.x, nextObj)
