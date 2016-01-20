
class Node {
    let data : Int
    var next : Node?
    var prev : Node?
    
    init(data: Int, prev : Node? = nil) {
        self.data = data
        self.prev = prev
    }
    
    func append(data : Int) -> Node {
        self.next = Node(data: data, prev: self)
        return self.next!
    }
}

class LinkedList {
    var head : Node?
    var tail: Node?
    
    func append(data : Int) {
        self.tail = self.tail?.append(data) ?? Node(data: data)
        
        if self.head == nil {
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