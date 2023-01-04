extension AVLTree: Equatable {
  @inlinable @inline(__always)
  public static func == (lhs: Self, rhs: Self) -> Bool {
    _isEqual(lhs.root, rhs.root)
  }
  
  @usableFromInline
  static func _isEqual(_ lhs: Node?, _ rhs: Node?) -> Bool {
    switch (lhs, rhs) {
    case (nil, nil):
      return true
    case let (leftNode?, rightNode?):
      let b1 = leftNode.value == rightNode.value
      let b2 = _isEqual(leftNode.leftChild, rightNode.leftChild)
      let b3 = _isEqual(leftNode.rightChild, rightNode.rightChild)
      return b1 && b2 && b3
    default:
      return false
    }
  }
}
