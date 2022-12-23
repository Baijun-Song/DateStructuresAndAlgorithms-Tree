extension AVLTree {
  @usableFromInline
  final class _Node: _BinaryNode {
    @usableFromInline
    var value: Element
    
    @usableFromInline
    var leftChild: _Node?
    
    @usableFromInline
    var rightChild: _Node?
    
    @usableFromInline
    var height = 0
    
    @inlinable @inline(__always)
    init(value: Element) {
      self.value = value
    }
    
    @inlinable @inline(__always)
    var leftHeight: Int {
      leftChild?.height ?? -1
    }
    
    @inlinable @inline(__always)
    var rightHeight: Int {
      rightChild?.height ?? -1
    }
    
    @inlinable @inline(__always)
    var balanceFactor: Int {
      leftHeight - rightHeight
    }
    
    @inlinable @inline(__always)
    func updateHeight() {
      height = 1 + max(leftHeight, rightHeight)
    }
  }
}
