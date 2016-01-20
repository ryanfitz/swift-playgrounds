//: Playground - noun: a place where people can play

import UIKit

class Node {
    let data : Int
    var next : Node?
    var prev : Node?
    
//    init(data: Int) {
//        self.data = data
//    }
    
    init(data: Int, prev : Node? = nil) {
        self.data = data
        self.prev = prev
    }
}

class LinkedList {
    var head : Node?
    var tail: Node?
    
    func append(data : Int) {
        let next = Node(data: data, prev: self.tail)
        
        if let t = self.tail {
            t.next = next
            self.tail = next
        } else {
            self.tail = next
        }
        
        if let h = self.head where h.next == nil {
            h.next = tail
        } else if self.head == nil {
            self.head = self.tail
        }
    }
    
    func printForward() {
        var next = self.head
        
        var d : [Int] = []
        
        while let n = next {
            d.append(n.data)
            next = n.next
        }
        
        print("print forward \(d)")
    }
    
    func printBackward() {
        var next = self.tail
        
        var d : [Int] = []
        
        while let n = next {
            d.append(n.data)
            next = n.prev
        }
        
        print("print back \(d)")
    }
}

let list = LinkedList()
list.append(2)
list.append(5)
list.append(6)
list.append(8)

list.printForward()
list.printBackward()