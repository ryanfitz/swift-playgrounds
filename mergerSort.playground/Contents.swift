//: Playground - noun: a place where people can play

import UIKit

func getElement(data: [Int], position: Int) -> Int? {
    if data.count > position {
        return data[position]
    }
    
    return nil
}

func merge(left: [Int], right: [Int]) -> [Int] {
    var result = [Int]()
    
    var leftPos = 0
    var rightPos = 0
    
    while leftPos < left.count || rightPos < right.count {
        let leftElm = getElement(left, position: leftPos)
        let rightElm = getElement(right, position: rightPos)
        
        if let l = leftElm, let r = rightElm {
            if (l < r) {
                result.append(l)
                leftPos++
            } else {
                result.append(r)
                rightPos++
            }
        } else if let l = leftElm {
            result.append(l)
            leftPos++
        } else {
            result.append(right[rightPos])
            rightPos++
        }
    }
    
    return result
}

func sort(data: [Int]) -> [Int] {
    guard data.count > 1 else {
        return data
    }
    
    let mid = data.count / 2
    let left = Array(data[0..<mid])
    let right = Array(data[mid...data.count - 1])
    
    return merge(sort(left), right: sort(right))
}

var s = sort([1, 4, 5, 4, 2, 3, 9, 22, 13, 8])

print("sorted \(s)")
//
//var singleChar = "ab"
//let c = "c"
//
//c.unicodeScalars.first?.value
//
//let chars = singleChar.characters.map { String($0) }
//chars[1].unicodeScalars.first!.value << 5
//chars[0].hashValue
