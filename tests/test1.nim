import unittest
import sets

import hrandom

test "generate 2^{20} random values":
  var
    generator = init(42)
    results = initHashSet[int64]()
    result: int64 = 0
    trials = 1 shl 20
  for _ in 0..<trials:
    (result, generator) = generator.rand()
    results.incl(result)
  check results.len == trials
  
test "generate 2^{20} random values included to [-1.5, 2.5]":
  var
    generator = init(42)
    results = initHashSet[float64]()
    result: float64 = 0.0
    trials = 1 shl 20
  let
    lb = -1.5
    ub = 2.5
  for _ in 0..<trials:
    (result, generator) = generator.rand(lb, ub)
    check lb <= result and result <= ub
    results.incl(result)
  check results.len == trials

test "generate 2^{20} random values included to {-1, 0, 1}":
  let
    lb = -1
    ub = 1
  var
    generator = init(42)
    result: int64 = 0
    trials = 1 shl 20
  for i in lb..ub:
    results[i] = 0
  for _ in 0..<trials:
    (result, generator) = generator.rand(lb, ub)
    check lb <= result and result <= ub
