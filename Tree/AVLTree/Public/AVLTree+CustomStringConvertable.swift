extension AVLTree: CustomStringConvertible {
  public var description: String {
    guard let root = root else {
      return "Empty AVL Tree"
    }
    let s1 = "AVL Tree:\n"
    let s2 = String(repeating: "-", count: 15) + "\n\n"
    let s3 = description(for: root)
    let s4 = "\n" + String(repeating: "-", count: 15)
    return s1 + s2 + s3 + s4
  }
  
  private func description(
    for node: Node?,
    top: String = "",
    root: String = "",
    bottom: String = ""
  ) -> String {
    guard let node = node else {
      return root + "nil\n"
    }
    if node.leftChild == nil, node.rightChild == nil {
      return root + "\(node.value)\n"
    } else {
      let s1 = description(
        for: node.rightChild,
        top: top + " ",
        root: top + "┌──",
        bottom: top + "│ "
      )
      let s2 = root + "\(node.value)\n"
      let s3 = description(
        for: node.leftChild,
        top: bottom + "│ ",
        root: bottom + "└──",
        bottom: bottom + " "
      )
      return s1 + s2 + s3
    }
  }
}
