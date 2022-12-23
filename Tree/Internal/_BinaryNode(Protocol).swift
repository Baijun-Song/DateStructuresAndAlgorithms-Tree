protocol _BinaryNode {
  associatedtype Value
  
  var value: Value { get set }
  
  var leftChild: Self? { get set }
  
  var rightChild: Self? { get set }
  
  var height: Int { get }
}

extension _BinaryNode {
  @inlinable @inline(__always)
  var height: Int {
    // TODO: - why inlinable code can interact with private code here?
    _height(of: self)
  }
  
  private func _height(of node: Self?) -> Int {
    if let node = node {
      let leftHeight = _height(of: node.leftChild)
      let rightHeight = _height(of: node.rightChild)
      return 1 + max(leftHeight, rightHeight)
    } else {
      return -1
    }
  }
}
