//: Playground - noun: a place where people can play

import UIKit

let shiftBits: UInt8 = 1   // 00000100 in binary
shiftBits << 1

shiftBits >> 2

let x: UInt8 = 128
let n: UInt8 = 2
let y = x & (~0 << 6)
