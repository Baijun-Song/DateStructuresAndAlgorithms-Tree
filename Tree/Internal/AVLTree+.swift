extension AVLTree {
  @inlinable @inline(__always)
  func leftRotate(
    _ node: _Node
  ) -> _Node {
    guard let pivot = node.rightChild else {
      return node
    }
    node.rightChild = pivot.leftChild
    node.updateHeight()
    pivot.leftChild = node
    pivot.updateHeight()
    return pivot
  }
  
  @inlinable @inline(__always)
  func rightRotate(
    _ node: _Node
  ) -> _Node {
    guard let pivot = node.leftChild else {
      return node
    }
    node.leftChild = pivot.rightChild
    node.updateHeight()
    pivot.rightChild = node
    pivot.updateHeight()
    return pivot
  }
  
  @inlinable @inline(__always)
  func rightLeftRotate(
    _ node: _Node
  ) -> _Node {
    guard let rightChild = node.rightChild else {
      return node
    }
    node.rightChild = rightRotate(rightChild)
    return leftRotate(node)
  }
  
  @inlinable @inline(__always)
  func leftRightRotate(
    _ node: _Node
  ) -> _Node {
    guard let leftChild = node.leftChild else {
      return node
    }
    node.leftChild = leftRotate(leftChild)
    return rightRotate(node)
  }
  
  @inlinable
  func balance(
    _ node: _Node
  ) -> _Node {
    var newNode = node
    switch node.balanceFactor {
    case 2:
      if let leftChild = node.leftChild {
        if leftChild.balanceFactor == -1 {
          newNode = leftRightRotate(node)
        }
      } else {
        newNode = rightRotate(node)
      }
    case -2:
      if let rightChild = node.rightChild {
        if rightChild.balanceFactor == 1 {
          newNode = rightLeftRotate(node)          
        }
      } else {
        newNode = leftRotate(node)
      }
    default:
      newNode.updateHeight()
    }
    return newNode
  }
  
  @usableFromInline
  func _inOrderTraverse(
    _ node: _Node?,
    result: inout [Element]
  ) {
    guard let node = node else {
      return
    }
    _inOrderTraverse(node.leftChild, result: &result)
    result.append(node.value)
    _inOrderTraverse(node.rightChild, result: &result)
  }
  
  @usableFromInline
  func _insert(
    _ newElement: Element,
    from node: _Node?
  ) -> _Node {
    guard let node = node else {
      return _Node(value: newElement)
    }
    if newElement < node.value {
      node.leftChild = _insert(newElement, from: node.leftChild)
    } else {
      node.rightChild = _insert(newElement, from: node.rightChild)
    }
    return balance(node)
  }
  
  @usableFromInline
  func _remove(
    _ element: Element,
    from node: _Node?,
    result: inout Element?
  ) -> _Node? {
    guard let node = node else {
      return nil
    }
    var newNode = node
    if element == node.value {
      result = element
      switch (node.leftChild, node.rightChild) {
      case let (_?, rightChild?):
        if let min = rightChild._removeFarLeftLeaf() {
          newNode.value = min
        } else {
          newNode.value = rightChild.value
          newNode.rightChild = nil
        }
      case let (leftChild?, nil):
        newNode = leftChild
      case let (nil, rightChild?):
        newNode = rightChild
      case (nil, nil):
        return nil
      }
    } else if element < node.value {
      newNode.leftChild = _remove(
        element,
        from: node.leftChild,
        result: &result
      )
    } else {
      newNode.rightChild = _remove(
        element,
        from: node.rightChild,
        result: &result
      )
    }
    return balance(newNode)
  }
}

extension AVLTree._Node {
  // TODO: - private or fileprivate inline
  // because it's never exposed outside module, will it ever be inlined?
  @inline(__always)
  fileprivate func _removeFarLeftLeaf() -> Element? {
    guard var currentLeft = leftChild else {
      return nil
    }
    var previousLeft = self
    while let leftChild = currentLeft.leftChild {
      previousLeft = currentLeft
      currentLeft = leftChild
    }
    previousLeft.leftChild = nil
    return currentLeft.value
  }
}
