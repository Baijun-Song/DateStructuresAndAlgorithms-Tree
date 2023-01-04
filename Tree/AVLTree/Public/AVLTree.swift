public struct AVLTree<Element: Comparable> {
  @usableFromInline
  var root: Node?
  
  @inlinable @inline(__always)
  public init() {}
}

extension AVLTree: BinaryTree {
  @inlinable @inline(__always)
  public var orderedElements: [Element] {
    var result: [Element] = []
    _inOrderTraverse(from: root, result: &result)
    return result
  }
  
  @inlinable
  public func contains(_ element: Element) -> Bool {
    var currentNode = root
    while let node = currentNode {
      if element < node.value {
        currentNode = node.leftChild
      } else if element == node.value {
        return true
      } else {
        currentNode = node.rightChild
      }
    }
    return false
  }
  
  @inlinable @inline(__always)
  public mutating func insert(_ newElement: Element) {
    update()
    root = _insert(newElement, from: root)
  }
  
  @inlinable @inline(__always)
  @discardableResult
  public mutating func remove(_ element: Element) -> Element? {
    update()
    var removedElement: Element?
    root = _remove(element, from: root, result: &removedElement)
    return removedElement
  }
}
