extension RedBlackTree {
  @usableFromInline
  final class Node: BinaryNode {
    @usableFromInline
    var value: Element
    
    @usableFromInline
    var leftChild: Node?
    
    @usableFromInline
    var rightChild: Node?
    
    @usableFromInline
    var color: Color
    
    @inlinable @inline(__always)
    init(value: Element, color: Color = .red) {
      self.value = value
      self.color = color
    }
  }
}
