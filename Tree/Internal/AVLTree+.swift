extension AVLTree {
  func _leftRotate(
    _ node: _Node
  ) -> _Node {
    guard let pivot = node._rightChild else {
      return node
    }
    node._rightChild = pivot._leftChild
    node._updateHeight()
    pivot._leftChild = node
    pivot._updateHeight()
    return pivot
  }
  
  func _rightRotate(
    _ node: _Node
  ) -> _Node {
    guard let pivot = node._leftChild else {
      return node
    }
    node._leftChild = pivot._rightChild
    node._updateHeight()
    pivot._rightChild = node
    pivot._updateHeight()
    return pivot
  }
  
  func _rightLeftRotate(
    _ node: _Node
  ) -> _Node {
    guard let rightChild = node._rightChild else {
      return node
    }
    node._rightChild = _rightRotate(rightChild)
    return _leftRotate(node)
  }
  
  func _leftRightRotate(
    _ node: _Node
  ) -> _Node {
    guard let leftChild = node._leftChild else {
      return node
    }
    node._leftChild = _leftRotate(leftChild)
    return _rightRotate(node)
  }
  
  func _balance(
    _ node: _Node
  ) -> _Node {
    var newNode = node
    switch node._balanceFactor {
    case 2:
      if let leftChild = node._leftChild {
        if leftChild._balanceFactor == -1 {
          newNode = _leftRightRotate(node)
        }
      } else {
        newNode = _rightRotate(node)
      }
    case -2:
      if let rightChild = node._rightChild {
        if rightChild._balanceFactor == 1 {
          newNode = _rightLeftRotate(node)          
        }
      } else {
        newNode = _leftRotate(node)
      }
    default:
      newNode._updateHeight()
    }
    return newNode
  }
}
