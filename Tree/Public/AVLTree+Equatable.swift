extension AVLTree: Equatable {
  @inlinable @inline(__always)
  public static func == (lhs: Self, rhs: Self) -> Bool {
    _isEqual(lhs.root, rhs.root)
  }
  
  @usableFromInline
  static func _isEqual(
    _ node1: _Node?,
    _ node2: _Node?
  ) -> Bool {
    switch (node1, node2) {
    case (nil, nil):
      return true
    case (let node1?, let node2?):
      let b1 = node1.value == node2.value
      let b2 = _isEqual(node1.leftChild, node2.leftChild)
      let b3 = _isEqual(node1.rightChild, node2.rightChild)
      return b1 && b2 && b3
    default:
      return false
    }
  }
}
