
class BinaryNode<T> {
    var val : T
    
    var left : BinaryNode<T>?
    var right : BinaryNode<T>?
    
    init(val : T) {
        self.val = val
    }
}

class BinarySearchTree<T:Comparable> {
    var root : BinaryNode<T>?
    
    var isValidBST : Bool {
       return self.isBST(self.root)
    }
    
    var min :  T? {
        guard let r = self.root else {
            return nil
        }
        
        return self.findMinNode(r).val
    }
    
    var max :  T? {
        guard let r = self.root else {
            return nil
        }
        
        return self.findMaxNode(r).val
    }
    
    func append(val : T) {
        let node = BinaryNode(val: val)
        
        if let r = root {
            self.appendNode(node, root: r)
        } else {
            root = node
        }
    }
    
    func find(val: T) -> BinaryNode<T>? {
        return self.find(val, root: self.root)
    }
    
    private func appendNode(node: BinaryNode<T>, root: BinaryNode<T>) {
        if root.left == nil && node.val < root.val {
            root.left = node
        } else if root.right == nil && node.val > root.val {
            root.right = node
        } else if let left = root.left where node.val < root.val {
            appendNode(node, root: left)
        } else if let right = root.right where node.val > root.val {
            appendNode(node, root: right)
        }
    }
    
    private func isBST(root : BinaryNode<T>? = nil) -> Bool {
        guard let node = root else {
            return true
        }
        
        if let l = node.left where l.val > node.val {
            return false
        } else if let r = node.right where r.val < node.val {
            return false
        } else {
            return isBST(node.left) && isBST(node.right)
        }
    }
    
    private func find(val: T, root: BinaryNode<T>?) -> BinaryNode<T>? {
        guard let node = root else {
            return nil
        }
        
        if node.val == val {
            return node
        } else if val > node.val {
            return find(val, root: node.right)
        } else {
            return find(val, root: node.left)
        }
    }
    
    private func findMinNode(root: BinaryNode<T>) -> BinaryNode<T> {
        if let left = root.left {
            return findMinNode(left)
        } else {
            return root
        }
    }
    
    func findMaxNode(root: BinaryNode<T>) -> BinaryNode<T> {
        if let right = root.right {
            return findMaxNode(right)
        } else {
            return root
        }
    }
}

let tree = BinarySearchTree<Int>()
tree.append(10)
tree.append(44)
tree.append(32)
tree.append(2)
tree.append(-2)

print("is tree valid BST? - \(tree.isValidBST)")
print("tree min \(tree.min)")
print("tree max \(tree.max)")

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