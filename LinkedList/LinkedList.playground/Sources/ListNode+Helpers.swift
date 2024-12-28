import Foundation

// keeping the same naming Leetcode does
public class ListNode {
  public var val: Int
  public var next: ListNode?

  public init(_ val: Int, _ next: ListNode? = nil) {
    self.val = val
    self.next = next
  }

  public init() {
    self.val = 0
  }
}

// MARK: - Helpers

// to array and from array conversions for easier input/output
extension Array where Element == Int {
  public var toListNode: ListNode? {
    guard !isEmpty else { return nil }
    let head = ListNode(self[0])
    var current = head
    for index in self.dropFirst().indices {
      let newNode = ListNode(self[index])
      current.next = newNode
      current = newNode
    }
    return head
  }
}

extension ListNode {
  public var toArray: [Int] {
    var result = [val]
    var current = self
    while let next = current.next {
      current = next
      result.append(current.val)
    }
    return result
  }
}
