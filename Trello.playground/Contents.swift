import Foundation

func hash(str: String) -> Int {
    var h = 7
    let chars = Array("acdegilmnoprstuw".characters)
    
    for idx in 0..<str.characters.count {
        let char = str[str.startIndex.advancedBy(idx)]
        if let charIndex = chars.indexOf(char) {
            h = h * 37 + charIndex
        }
    }
    
    return h
}

func unhash(hash: Int) -> String {
    let chars = Array("acdegilmnoprstuw".characters)
    
    var result = [Character]()
    
    var charIdx = 0
    var h = hash
    
    while h > 7 {
        charIdx = h % 37
        result.append(chars[charIdx])
        
        h = (h - charIdx) / 37
    }
    
    return String(result.reverse())
}

func unhashRecursive(hash: Int, availableLetters: [Character] = Array("acdegilmnoprstuw".characters), acc: String = "") -> String {
    guard hash > 7 else {
        return acc
    }
    
    let charIdx = hash % 37
    let letter = String(availableLetters[charIdx])
    
    let nextHash = (hash - charIdx) / 37
    
    return unhashRecursive(nextHash, availableLetters: availableLetters, acc: letter + acc)
}

let h = hash("leepadg")
unhash(h)
assert("leepadg" == unhash(h))

let u = unhash(25377615533200)
hash(u)
assert(25377615533200 == hash(u))

let ur = unhashRecursive(25377615533200)
hash(ur)
assert(25377615533200 == hash(ur))

