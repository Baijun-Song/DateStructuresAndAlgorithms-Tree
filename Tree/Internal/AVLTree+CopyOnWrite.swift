extension AVLTree {
  mutating func _update() {
    guard
      !isKnownUniquelyReferenced(&_root),
      let root = _root
    else {
      return
    }
    _root = __duplicate(root)
  }
  
  private func __duplicate(
    _ node: _Node
  ) -> _Node {
    let newNode = _Node(value: node._value)
    newNode._height = node._height
    if let leftChild = node._leftChild {
      newNode._leftChild = __duplicate(leftChild)
    }
    if let rightChild = node._rightChild {
      newNode._rightChild = __duplicate(rightChild)
    }
    return newNode
  }
}
