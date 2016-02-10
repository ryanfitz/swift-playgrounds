//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

func wordBreak(str: String, words : [String]) {
    let dict = words.reduce([String: Bool]()) { (var result, word) in
        result[word] = true
        return result
    }
    
    print(segmentString(str, dict: dict))
}

func segmentString(str: String, dict : [String: Bool]) -> [[String]]? {
    var result = [[String]]()
    
    for var i = 1; i <= str.characters.count ; i++ {
        let prefix = str[str.startIndex.advancedBy(0)..<str.startIndex.advancedBy(i)]
        
        if let _ = dict[prefix] {
            var words = [prefix]
            
            let suffix = str[str.startIndex.advancedBy(i)..<str.endIndex]
            if let segSuffix = segmentString(suffix, dict: dict) {
                words.appendContentsOf(segSuffix.flatten())
            }
            
            result.append(words)
        }
    }
    
    if result.count >= 1 {
        return result
    } else {
        return nil
    }
}

wordBreak("catsanddog", words: ["dog", "cats", "sand", "cat", "and", "foo", "bar"])
wordBreak("foobarzar", words: ["dog", "cats", "sand", "cat", "and", "foo", "bar", "barzar"])
