public protocol BinaryTree {
  associatedtype Element
  
  var orderedElements: [Element] { get }
  
  func contains(_ element: Element) -> Bool
  
  mutating func insert(_ newElement: Element)
  
  @discardableResult
  mutating func remove(_ element: Element) -> Element?
}

extension BinaryTree {
  @usableFromInline
  func _inOrderTraverse<T>(
    from node: T?,
    result: inout [Element]
  ) where T: BinaryNode, T.Value == Element {
    guard let node = node else {
      return
    }
    _inOrderTraverse(from: node.leftChild, result: &result)
    result.append(node.value)
    _inOrderTraverse(from: node.rightChild, result: &result)
  }
}
