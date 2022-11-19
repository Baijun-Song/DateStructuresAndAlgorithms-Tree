extension AVLTree: Equatable {
  public static func == (lhs: Self, rhs: Self) -> Bool {
    __isEqual(lhs._root, rhs._root)
  }
  
  private static func __isEqual(
    _ node1: _Node?,
    _ node2: _Node?
  ) -> Bool {
    switch (node1, node2) {
    case (nil, nil):
      return true
    case (let node1?, let node2?):
      let b1 = node1._value == node2._value
      let b2 = __isEqual(node1._leftChild, node2._leftChild)
      let b3 = __isEqual(node1._rightChild, node2._rightChild)
      return b1 && b2 && b3
    default:
      return false
    }
  }
}
