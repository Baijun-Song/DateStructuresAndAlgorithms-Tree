extension AVLTree {
  func leftRotate(_ node: Node) -> Node {
    guard let pivot = node.rightChild else {
      return node
    }
    node.rightChild = pivot.leftChild
    node.updateHeight()
    pivot.leftChild = node
    pivot.updateHeight()
    return pivot
  }
  
  func rightRotate(_ node: Node) -> Node {
    guard let pivot = node.leftChild else {
      return node
    }
    node.leftChild = pivot.rightChild
    node.updateHeight()
    pivot.rightChild = node
    pivot.updateHeight()
    return pivot
  }
  
  func rightLeftRotate(_ node: Node) -> Node {
    guard let rightChild = node.rightChild else {
      return node
    }
    node.rightChild = rightRotate(rightChild)
    return leftRotate(node)
  }
  
  func leftRightRotate(_ node: Node) -> Node {
    guard let leftChild = node.leftChild else {
      return node
    }
    node.leftChild = leftRotate(leftChild)
    return rightRotate(node)
  }
  
  func balance(_ node: Node) -> Node {
    switch node.balanceFactor {
    case 2:
      if let leftChild = node.leftChild {
        if leftChild.balanceFactor == -1 {
          return leftRightRotate(node)
        }
      } else {
        return rightRotate(node)
      }
    case -2:
      if let rightChild = node.rightChild {
        if rightChild.balanceFactor == 1 {
          return rightLeftRotate(node)
        }
      } else {
        return leftRotate(node)
      }
    default:
      node.updateHeight()
    }
    return node
  }
  
  @usableFromInline
  func _insert(
    _ newElement: Element,
    from node: Node?
  ) -> Node {
    guard let node = node else {
      return Node(value: newElement)
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
    from node: Node?,
    result: inout Element?
  ) -> Node? {
    guard let node = node else {
      return nil
    }
    if element < node.value {
      node.leftChild = _remove(
        element,
        from: node.leftChild,
        result: &result
      )
    } else if element == node.value {
      result = element
      switch (node.leftChild, node.rightChild) {
      case let (_?, rightChild?):
        if let min = rightChild.removeFarLeftLeaf() {
          node.value = min
        } else {
          node.value = rightChild.value
          node.rightChild = nil
        }
      case let (leftChild?, nil):
        return balance(leftChild)
      case let (nil, rightChild?):
        return balance(rightChild)
      case (nil, nil):
        return nil
      }
    } else {
      node.rightChild = _remove(
        element,
        from: node.rightChild,
        result: &result
      )
    }
    return balance(node)
  }
}

extension AVLTree.Node {
  @inline(__always)
  fileprivate func removeFarLeftLeaf() -> Element? {
    guard var currLeft = leftChild else {
      return nil
    }
    var prevLeft = self
    while let leftChild = currLeft.leftChild {
      prevLeft = currLeft
      currLeft = leftChild
    }
    prevLeft.leftChild = nil
    return currLeft.value
  }
}
