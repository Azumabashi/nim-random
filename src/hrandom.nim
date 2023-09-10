import math

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

proc rand*(gen: XorShift, left, right: float64): (float64, XorShift) =
  assert left <= right
  let (val, nextGen) = gen.rand()
  let ratio = (float64(val) - float64(low(int64))) / (float64(high(int64)) - float64(low(int64)))
  let res = left + ratio * (right - left)
  (res, nextGen)

proc rand*(gen: XorShift, left, right: int64): (int64, XorShift) =
  assert left <= right
  let offset = 0.499999999999
  let (val, nextGen) = gen.rand(left.toFloat - offset, right.toFloat + offset)
  (int64(round(val)), nextGen)

proc shuffle*[T](arr: seq[T], gen: XorShift): (seq[T], XorShift) =
  var
    newArr = arr
    nextGen = gen
    j = 0
  for i in 0..<arr.len:
    (j, nextGen) = nextGen.rand(0, arr.len - 1)
    let tmp = newArr[j]
    newArr[j] = newArr[i]
    newArr[i] = tmp
  (newArr, nextGen)
