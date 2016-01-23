
class Node<T> {
    var val : T
    
    var next : Node<T>?
    
    init(val : T) {
        self.val = val
    }
}

class Stack<T> {
    var head : Node<T>?
    
    var isEmpty : Bool {
        return head == nil
    }
    
    func push(item: T) {
        let newHead = Node<T>(val: item)
        
        if let existingHead = self.head {
            newHead.next = existingHead
        }
        
        self.head = newHead
    }
    
    func pop() -> T? {
        guard let existingHead = self.head else {
            return nil
        }
        
        self.head = existingHead.next
        
        return existingHead.val
    }
}

let s = Stack<Int>()

s.push(1)
s.push(2)
s.push(3)

while !s.isEmpty {
    print("stack pop \(s.pop())")
}