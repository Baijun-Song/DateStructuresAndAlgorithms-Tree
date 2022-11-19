public struct AVLTree<Element: Comparable> {
  var _root: _Node?
  
  public init() {}
}

extension AVLTree {
  public var orderedElements: [Element] {
    var result: [Element] = []
    __inOrderTraverse(_root, result: &result)
    return result
  }
  
  private func __inOrderTraverse(
    _ node: _Node?,
    result: inout [Element]
  ) {
    guard let node = node else {
      return
    }
    __inOrderTraverse(node._leftChild, result: &result)
    result.append(node._value)
    __inOrderTraverse(node._rightChild, result: &result)
  }
  
  public mutating func insert(_ newElement: Element) {
    _update()
    _root = __insert(newElement, from: _root)
  }
  
  private func __insert(
    _ newElement: Element,
    from node: _Node?
  ) -> _Node {
    guard let node = node else {
      return _Node(value: newElement)
    }
    if newElement < node._value {
      node._leftChild = __insert(newElement, from: node._leftChild)
    } else {
      node._rightChild = __insert(newElement, from: node._rightChild)
    }
    return _balance(node)
  }
  
  public func contains(_ element: Element) -> Bool {
    var currentNode = _root
    while let node = currentNode {
      if element < node._value {
        currentNode = node._leftChild
      } else if element == node._value {
        return true
      } else {
        currentNode = node._rightChild
      }
    }
    return false
  }
  
  @discardableResult
  public mutating func remove(_ element: Element) -> Element? {
    _update()
    var removedElement: Element?
    _root = __remove(element, from: _root, result: &removedElement)
    return removedElement
  }
  
  private func __remove(
    _ element: Element,
    from node: _Node?,
    result: inout Element?
  ) -> _Node? {
    guard let node = node else {
      return nil
    }
    var newNode = node
    if element == node._value {
      result = element
      if let leftChild = node._leftChild {
        if let rightChild = node._rightChild {
          if let min = rightChild.__removeFarLeftLeaf() {
            newNode._value = min
          } else {
            newNode._value = rightChild._value
            newNode._rightChild = nil
          }
        } else {
          newNode = leftChild
        }
      } else {
        if let rightChild = node._rightChild {
          newNode = rightChild
        } else {
          return nil
        }
      }
    } else if element < node._value {
      newNode._leftChild = __remove(
        element,
        from: node._leftChild,
        result: &result
      )
    } else {
      newNode._rightChild = __remove(
        element,
        from: node._rightChild,
        result: &result
      )
    }
    return _balance(newNode)
  }
}

extension AVLTree._Node {
  fileprivate func __removeFarLeftLeaf() -> Value? {
    guard var currentLeft = _leftChild else {
      return nil
    }
    var previousLeft = self
    while let leftChild = currentLeft._leftChild {
      previousLeft = currentLeft
      currentLeft = leftChild
    }
    previousLeft._leftChild = nil
    return currentLeft._value
  }
}
