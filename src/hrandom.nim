type
  XorShift* = ref object
    x: int64

proc init*(seed: int64): XorShift =
  XorShift(x: seed)

proc rand*(gen: XorShift): (int64, XorShift) =
  var nextGen = gen
  nextGen.x = nextGen.x xor (nextGen.x shl 13)
  nextGen.x = nextGen.x xor (nextGen.x shr 7)
  nextGen.x = nextGen.x xor (nextGen.x shl 17)
  (nextGen.x, nextGen)
