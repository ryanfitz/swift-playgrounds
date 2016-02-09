//: Playground - noun: a place where people can play

import UIKit

func cleanString(text: String) -> String {
    return text.stringByReplacingOccurrencesOfString(" ", withString: "").stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
}

func canMakeNote(note: String, magazine: String) -> Bool {
    var result = true
    
    var lettersIndex = cleanString(magazine).characters.reduce([String: Int]()) { (var result, char) -> [String: Int] in
        let str = String(char)
        let count = result[str] ?? 0
        result[str] = count + 1
        
        return result
    }
    
    for char in cleanString(note).characters {
        let str = String(char)
        if let count = lettersIndex[str] where count >= 1 {
            lettersIndex[str] = count - 1
        } else {
            result = false
            break
        }
        
    }
    
    return result
}

canMakeNote("hell", magazine: "hello")
canMakeNote("hell", magazine: "ello")
canMakeNote("he zar", magazine: "foo bar the")
canMakeNote("he bar", magazine: "foo bar the")

func canMakeNoteOpt(note: String, magazine: String) -> Bool {
    let noteArray = cleanString(note).characters.map { String($0) }
    let magArray = cleanString(magazine).characters.map { String($0) }
    var lettersIndex = [String: Int]()
    
    var noteIndex = 0
    var magIndex = 0
    
    while noteIndex < noteArray.count && magIndex <= magArray.count {
        let noteChar = noteArray[noteIndex]
        
        if let count = lettersIndex[noteChar] where count >= 1 {
            lettersIndex[noteChar] = count - 1
            noteIndex++
        } else {
            if magIndex < magArray.count {
                let magChar = magArray[magIndex]
                let count = lettersIndex[magChar] ?? 0
                lettersIndex[magChar] = count + 1
            }
            
            magIndex++
        }
    }
    
    print("noteIdx \(noteIndex) magIndex \(magIndex) \(lettersIndex) ")
    if noteIndex >= noteArray.count {
        return true
    } else {
        return false
    }
}

canMakeNoteOpt("hell", magazine: "hello")
canMakeNoteOpt("hell", magazine: "ello")
canMakeNoteOpt("he bar", magazine: "foobarthe")
canMakeNoteOpt("he zar", magazine: "foo bar the")