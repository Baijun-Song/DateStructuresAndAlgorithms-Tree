protocol _BinaryNode {
  associatedtype Value
  
  var _value: Value { get set }
  
  var _leftChild: Self? { get set }
  
  var _rightChild: Self? { get set }
  
  var _height: Int { get }
}

extension _BinaryNode {
  var _height: Int {
    __height(of: self)
  }
  
  private func __height(of node: Self?) -> Int {
    if let node = node {
      let leftHeight = __height(of: node._leftChild)
      let rightHeight = __height(of: node._rightChild)
      return 1 + max(leftHeight, rightHeight)
    } else {
      return -1
    }
  }
}
