import unittest
import sets

import hrandom

test "generate 2^{20} random values":
  var
    generator = init(42)
    results = initHashSet[uint64]()
    result: uint64 = 0
    trials = 1 shl 20
  for _ in 0..<trials:
    (result, generator) = generator.rand()
    results.incl(result)
  check results.len == trials
  
