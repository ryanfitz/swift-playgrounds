//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// Input:  words[] = {"baa", "abcd", "abca", "cab", "cad"}
// Output: Order of characters is 'b', 'd', 'a', 'c'

func diffLetters(word1 : String, word2: String) -> (parent:String?, child:String?) {
    let word1Arr = word1.characters.map { String($0) }
    let word2Arr = word2.characters.map { String($0) }
    
    var result : (parent:String?, child:String?) = (parent: nil, child: nil)
    
    for var idx = 0; idx < word1Arr.count && idx < word2Arr.count; idx++ {
        let parent = word1Arr[idx]
        let child = word2Arr[idx]
        
        if parent != child {
            result = (parent: parent, child: child)
            break
        }
    }
    
    return result
}

class GraphNode {
    let val : String
    var edges = [GraphNode]()
    var visited = false
    
    init(val: String) {
        self.val = val
    }
    
    func addEdge(node: GraphNode) {
        self.edges.append(node)
    }
}

class DirectedGraph {
    var nodes = [String : GraphNode]()
    
    func addEdge(parent : String, child : String) {
        let parentNode : GraphNode = nodes[parent] ?? GraphNode(val: parent)
        let childNode : GraphNode = nodes[child] ?? GraphNode(val: child)

        parentNode.addEdge(childNode)
        
        self.nodes[parent] = parentNode
        self.nodes[child] = childNode
    }
    
    func topologicalSort() -> [GraphNode] {
        var stack = [GraphNode]()
        
        for (_ , node) in self.nodes {
            if !node.visited {
                sortUtil(node, stack: &stack)
            }
        }
        
        return stack.reverse()
    }
    
    private func sortUtil(node : GraphNode, inout stack: [GraphNode]) {
        node.visited = true
        
        for edge in node.edges {
            if (!edge.visited) {
                sortUtil(edge, stack: &stack)
            }
        }
        
        stack.append(node)
    }
}

func generateGraph(words: [String]) {
    
    let graph = DirectedGraph()
    
    for var idx = 0; idx < words.count - 1; idx++ {
        let firstWord = words[idx]
        let secondWord = words[idx + 1]
        
        let g = diffLetters(firstWord, word2: secondWord)
        if let p = g.parent, let c = g.child {
            graph.addEdge(p, child: c)
        }
    }
    
    let vals = graph.topologicalSort().map { $0.val }
    print("index is \(vals)")
}

let words = ["baa", "abcd", "abca", "cab", "cad"]
generateGraph(words)
