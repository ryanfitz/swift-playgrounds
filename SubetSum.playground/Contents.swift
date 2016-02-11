//: Playground - noun: a place where people can play

import UIKit

func subsetSum(numbers : [Int], target : Int) -> Bool {
    
    var matrix = [[Bool]]()
    for _ in 0...numbers.count {
       matrix.append([true])
    }
    
    for row in 0..<numbers.count {
        let currentNum = numbers[row]
        
        for col in 1...target {
            var isSum = false
            var back = false
            
            if col - currentNum >= 0 {
               back = matrix[row][col - currentNum]
            }
            
            if (row >= 1) {
                isSum = matrix[row - 1][col] || back
            } else {
                isSum = back
            }
            
            matrix[row].append(isSum)
        }
    }
    
//    print(matrix[numbers.count - 1][target])
    return matrix[numbers.count - 1][target]
}

subsetSum([3, 5, 21], target: 4)
subsetSum([3, 5, 21], target: 6)
subsetSum([3, 12, 21], target: 22)

func subsetSumUniq(numbers : [Int], target : Int) -> Bool {
    
    var matrix = [[Bool]]()
    for idx in 0...numbers.count {
        matrix.append([true])
        if idx == 0 {
            for _ in 1...target {
                matrix[0].append(false)
            }
        }
    }
    
    for row in 1...numbers.count {
        let currentNum = numbers[row - 1]
        
        for col in 1...target {
            var isSum = false
            var back = false
            
            let prevSum = matrix[row - 1][col]
            
            if col - currentNum >= 0 {
                if (col - currentNum) < matrix[row - 1].count {
                    back = matrix[row - 1][col - currentNum]
                }
            }
            
            isSum = back || prevSum
            
            matrix[row].append(isSum)
        }
    }
    
    return matrix[numbers.count][target]
}

subsetSumUniq([3, 5, 21], target: 4)
subsetSumUniq([3, 5, 21], target: 6)
subsetSumUniq([3, 5, 21], target: 8)
subsetSumUniq([3, 12, 21], target: 22)
subsetSumUniq([3, 12, 21], target: 24)

typealias knapItem = (w: Int, v: Int)

func knapsack(numbers : [knapItem], target : Int) -> Int {
    
    var matrix = [[Int]]()
    for _ in 0..<numbers.count {
        matrix.append([0])
    }
    
    for row in 0..<numbers.count {
        let current = numbers[row]
        
        for col in 1...target {
            var prevSum = 0
            var sum = 0
            var back = 0
            
            if (row >= 1) {
                prevSum = matrix[row - 1][col]
                
                if col - current.w >= 0 {
                    back = matrix[row - 1][col -  current.w]
                }
            }
            
            if current.w <= col && (current.v + back) > prevSum {
               sum = current.v + back
            } else {
               sum = prevSum
            }
            
            matrix[row].append(sum)
        }
    }
    
    printKnapsack(numbers, matrix: matrix)
    return matrix[numbers.count - 1][target]
}

func printKnapsack(numbers: [knapItem], matrix : [[Int]]) {
    var result = [knapItem]()
    
    let maxValue = matrix[numbers.count - 1].last!
    
    for var row = matrix.count - 1, col = matrix.last!.count - 1; row >= 0 && col >= 0; row-- {
        var prevSum = 0
        if row >= 1 {
           prevSum = matrix[row - 1][col]
        }
        
        if matrix[row][col] > prevSum {
            result.append(numbers[row])
            
            if row >= 1 {
                col = col - numbers[row].w
            }
        }
    }
    
    print("maxval: \(maxValue) knapsack - \(result)")
}

knapsack([(w: 1, v: 2)], target: 6)
knapsack([(w: 1, v: 2), (w: 4, v: 2), (w: 3, v: 3)], target: 8)
knapsack([(w: 1, v: 2), (w: 2, v: 2), (w: 9, v: 11), (w: 6, v: 11) ], target: 6)
knapsack([(w: 1, v: 2), (w: 5, v: 5), (w: 2, v: 2), (w: 9, v: 11) ], target: 6)
