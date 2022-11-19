extension AVLTree: CustomStringConvertible {
  public var description: String {
    guard let rootNode = _root else {
      return "Empty AVL Tree"
    }
    let s1 = "AVL Tree:\n"
    let s2 = String(repeating: "-", count: 15) + "\n\n"
    let s3 = __diagram(for: rootNode)
    let s4 = "\n" + String(repeating: "-", count: 15)
    return s1 + s2 + s3 + s4
  }
  
  private func __diagram(
    for node: _Node?,
    top: String = "",
    root: String = "",
    bottom: String = ""
  ) -> String {
    guard let node = node else {
      return root + "nil\n"
    }
    if node._leftChild == nil, node._rightChild == nil {
      return root + "\(node._value)\n"
    } else {
      let s1 = __diagram(
        for: node._rightChild,
        top: top + " ",
        root: top + "┌──",
        bottom: top + "│ "
      )
      let s2 = root + "\(node._value)\n"
      let s3 = __diagram(
        for: node._leftChild,
        top: bottom + "│ ",
        root: bottom + "└──",
        bottom: bottom + " "
      )
      return s1 + s2 + s3
    }
  }
}
