import Foundation

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

class BinaryNode<T> {
    var val : T
    
    var left : BinaryNode<T>?
    var right : BinaryNode<T>?
    
    var isLeaf : Bool {
        return left == nil && right == nil
    }
    
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
    
    func findNearest(val : T) -> T? {
        guard let r = self.root else {
            return nil
        }
        
        return self.findNear(val, nearest: nil, root: r)?.val
    }
    
    var count = 0;
    func findNear(val: T, nearest: BinaryNode<T>?, root: BinaryNode<T>?) -> BinaryNode<T>? {
        print("foo bar \(count++)")
        guard let rootNode = root else {
            return nearest
        }
        
        if val == rootNode.val {
            return rootNode
        }
        
        var newNearest = nearest
        if let near = nearest where rootNode.val > near.val && rootNode.val < val {
            newNearest = rootNode
        } else if newNearest == nil && rootNode.val < val {
            newNearest = rootNode
        }
        
        if let left = rootNode.left where val < rootNode.val && left.val < newNearest?.val {
            return newNearest
        }
        
        if val < rootNode.val {
            return findNear(val, nearest: newNearest, root: rootNode.left)
        } else {
            return findNear(val, nearest: newNearest, root: rootNode.right)
        }
    }
    
    func inOrder() -> [T] {
        let que = Queue<T>()
        inOrder(self.root, queue: que)
        
        var result = [T]()
        for item in que {
           result.append(item)
        }
        
        return result
    }
    
    func preOrder() -> [T] {
        let que = Queue<T>()
        preOrder(self.root, queue: que)
        
        var result = [T]()
        for item in que {
            result.append(item)
        }
        
        return result
    }
    
    func postOrder() -> [T] {
        let que = Queue<T>()
        postOrder(self.root, queue: que)
        
        var result = [T]()
        for item in que {
            result.append(item)
        }
        
        return result
    }
    
    private func inOrder(root: BinaryNode<T>?, queue : Queue<T>) {
        guard let r = root else {
            return
        }
        
        inOrder(r.left, queue: queue)
        queue.push(r.val)
        inOrder(r.right, queue: queue)
    }
    
    private func preOrder(root: BinaryNode<T>?, queue : Queue<T>) {
        guard let r = root else {
            return
        }
        
        queue.push(r.val)
        preOrder(r.left, queue: queue)
        preOrder(r.right, queue: queue)
    }
    
    private func postOrder(root: BinaryNode<T>?, queue : Queue<T>) {
        guard let r = root else {
            return
        }
        
        postOrder(r.left, queue: queue)
        postOrder(r.right, queue: queue)
        queue.push(r.val)
    }
}

let tree = BinarySearchTree<Int>()
for i in 1...20 {
    tree.append(Int(arc4random_uniform(200) + 1))
}

print("is tree valid BST? - \(tree.isValidBST)")
print("tree min \(tree.min)")
print("tree max \(tree.max)")
print("nearest \(tree.findNearest(17))")

print("in order \(tree.inOrder())")
print("pre order \(tree.preOrder())")
print("post order \(tree.postOrder())")