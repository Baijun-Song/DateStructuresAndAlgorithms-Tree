extension AVLTree {
  @inlinable @inline(__always)
  mutating func update() {
    guard
      !isKnownUniquelyReferenced(&root),
      let root = root
    else {
      return
    }
    self.root = _duplicate(root)
  }
  
  @usableFromInline
  func _duplicate(_ node: Node) -> Node {
    let newNode = Node(
      value: node.value,
      height: node.height
    )
    if let leftChild = node.leftChild {
      newNode.leftChild = _duplicate(leftChild)
    }
    if let rightChild = node.rightChild {
      newNode.rightChild = _duplicate(rightChild)
    }
    return newNode
  }
}
