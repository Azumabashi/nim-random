# This is just an example to get you started. A typical library package
# exports the main API in this file. Note that you cannot rename this file
# but you can remove it if you wish.

type
  XorShift* = ref object
    x: int

proc rand(obj: XorShift): (int, XorShift) =
  var nextObj = obj
  nextObj.x = nextObj.x shl 13
  nextObj.x = nextObj.x shr 7
  nextObj.x = nextObj.x shl 17
  (nextObj.x, nextObj)
