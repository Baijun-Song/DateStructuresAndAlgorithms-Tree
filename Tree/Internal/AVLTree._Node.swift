extension AVLTree {
  final class _Node: _BinaryNode {
    var _value: Element
    var _leftChild: _Node?
    var _rightChild: _Node?
    var _height = 0
    
    init(value: Value) {
      self._value = value
    }
    
    var _leftHeight: Int {
      _leftChild?._height ?? -1
    }
    
    var _rightHeight: Int {
      _rightChild?._height ?? -1
    }
    
    var _balanceFactor: Int {
      _leftHeight - _rightHeight
    }
    
    func _updateHeight() {
      _height = 1 + max(_leftHeight, _rightHeight)
    }
  }
}
