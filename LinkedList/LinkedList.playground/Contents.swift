import Foundation

// MARK: - 206. Reverse Linked List [Easy]
// https://leetcode.com/problems/reverse-linked-list/
// Given the head of a singly linked list, reverse the list, and return the reversed list.

func reverseLinkedList(_ head: ListNode?) -> ListNode? {
  guard var head else { return nil }
  var tail = ListNode(head.val)
  while let next = head.next {
    tail = ListNode(next.val, tail)
    head = next
  }
  return tail
}

reverseLinkedList([1, 2, 3, 4, 5].toListNode)?.toArray ?? []
reverseLinkedList([1, 2].toListNode)?.toArray ?? []
reverseLinkedList([].toListNode)?.toArray ?? []
