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

let h = hash("leepadg")
unhash(h)
assert("leepadg" == unhash(h))

let u = unhash(25377615533200)
hash(u)
assert(25377615533200 == hash(u))
