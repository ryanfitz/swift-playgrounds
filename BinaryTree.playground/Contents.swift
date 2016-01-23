//: Playground - noun: a place where people can play

import UIKit

class BinaryNode : CustomStringConvertible {
    var left : BinaryNode?
    var right : BinaryNode?
    weak var parent : BinaryNode?
    
    var val : Int
    
    init(val : Int) {
        self.val = val
    }
    
    var description: String {
        let l = left?.val
        let r = right?.val
        
        return "val \(val): left \(l) right \(r)"
    }
}

class BinarySearchTree {
    var root : BinaryNode?
    
    func append(val : Int) {
        let node = BinaryNode(val: val)
        
        if let r = root {
            self.appendNode(node, root: r)
        } else {
            root = node
        }
    }
    
    private func appendNode(node: BinaryNode, root: BinaryNode) {
        if root.left == nil && node.val < root.val {
            root.left = node
            node.parent = root
        } else if root.right == nil && node.val > root.val {
            root.right = node
            node.parent = root
        } else if let left = root.left where node.val < root.val {
            appendNode(node, root: left)
        } else if let right = root.right where node.val > root.val {
            appendNode(node, root: right)
        }
    }
    
    func remove(val: Int) {
        guard let node = self.find(val) else {
            return
        }
        
        removeNode(node)
    }
    
    func removeNode(node: BinaryNode) {
        if node.left == nil && node.right == nil {
            self.removeParentLink(node)
        } else if let right = node.right {
            let minNode = self.findMinNode(right)
            node.val = minNode.val
            removeNode(minNode)
        } else if let left = node.left {
            let maxNode = self.findMaxNode(left)
            node.val = maxNode.val
            removeNode(maxNode)
        }
    }
    
    private func removeParentLink(node: BinaryNode) {
        if let p = node.parent {
            if p.left?.val == node.val {
                p.left = nil
            } else if p.right?.val == node.val {
                p.right = nil
            }
        }
    }
    
    func isValidBST() -> Bool {
       return self.isBST(self.root)
    }
    
    func isBST(root : BinaryNode? = nil) -> Bool {
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
    
    func find(val: Int) -> BinaryNode? {
        return self.find(val, root: self.root)
    }
    
    private func find(val: Int, root: BinaryNode?) -> BinaryNode? {
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
    
    func findMin() -> BinaryNode? {
        guard let node = self.root else {
            return nil
        }
        
        return findMinNode(node)
    }
    
    func findMax() -> BinaryNode? {
        guard let node = self.root else {
            return nil
        }
        
        return findMaxNode(node)
    }
    
    func findMinNode(root: BinaryNode) -> BinaryNode {
        if let left = root.left {
            return findMinNode(left)
        } else {
            return root
        }
    }
    
    func findMaxNode(root: BinaryNode) -> BinaryNode {
        if let right = root.right {
            return findMaxNode(right)
        } else {
            return root
        }
    }
}

func badTree() -> BinaryNode {
    let root = BinaryNode(val: 10)
    root.left = BinaryNode(val: 8)
    root.right = BinaryNode(val: 11)
    
    root.right?.left = BinaryNode(val: 9)
    root.right?.right = BinaryNode(val: 29)
    
    return root
}

let tree = BinarySearchTree()
tree.append(12)
tree.append(15)
tree.append(9)
tree.append(4)
tree.append(24)
tree.append(44)
tree.append(3)
tree.append(6)
tree.append(23)

print("find \(tree.find(66))")
//print("root \(tree.root)")
//print("tree is bst \(tree.isValidBST())")
tree.isValidBST()

tree.isBST(badTree())
print("badtree is bst \(tree.isBST(badTree()))")

tree.findMin()
tree.findMax()

tree.remove(9)
print("find \(tree.find(12))")

let tree2 = BinarySearchTree()
tree2.append(12)
tree2.append(9)
tree2.append(7)
tree2.append(8)
tree2.append(15)
tree2.remove(9)
tree2.remove(12)
print("find 2 \(tree2.find(12))")
print("find 2 \(tree2.find(8))")
tree2.isBST()