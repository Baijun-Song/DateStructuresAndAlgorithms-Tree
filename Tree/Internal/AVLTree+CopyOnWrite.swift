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
  func _duplicate(
    _ node: _Node
  ) -> _Node {
    let newNode = _Node(value: node.value)
    newNode.height = node.height
    if let leftChild = node.leftChild {
      newNode.leftChild = _duplicate(leftChild)
    }
    if let rightChild = node.rightChild {
      newNode.rightChild = _duplicate(rightChild)
    }
    return newNode
  }
}
