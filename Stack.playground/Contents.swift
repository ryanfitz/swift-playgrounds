
class Node<T> {
    var val : T
    
    var next : Node<T>?
    
    init(val : T) {
        self.val = val
    }
}

class Stack<T> : SequenceType {
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
    
    func generate() -> AnyGenerator<T> {
        return anyGenerator {
            return self.pop()
        }
    }
}

class Queue<T> : SequenceType {
    var head : Node<T>?
    var tail : Node<T>?
    
    var isEmpty : Bool {
        return head == nil
    }
    
    func push(item: T) {
        let node = Node(val: item)
        
        if let t = self.tail {
            t.next = node
        }
        
        self.tail = node
        
        if self.head == nil {
            self.head = self.tail
        }
    }
    
    func pop() -> T? {
        guard let h = self.head else {
            return nil
        }
        
        let result = h.val
        self.head = h.next
        
        if self.head == nil {
            self.tail = nil
        }
        
        return result
    }
    
    func generate() -> AnyGenerator<T> {
        return anyGenerator {
            return self.pop()
        }
    }
}

func runQueueStackExamples() {
    let s = Stack<Int>()
    s.push(1)
    s.push(2)
    s.push(3)

    for val in s {
        print("stack pop \(val)")
    }

    //let a = s.map { $0 * 5 }

    print("===========================")
    let q = Queue<Int>()
    q.push(1)
    q.push(2)
    q.push(3)

    for val in q {
        print("queue pop \(val)")
    }

    q.push(9)
    q.push(2)
    q.push(11)

    print("===========================")
    for val in q {
        print("queue pop \(val)")
    }
}