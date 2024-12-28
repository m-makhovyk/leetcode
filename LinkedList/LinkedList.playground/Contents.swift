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


// MARK: - 2. Add Two Numbers [Medium]
// https://leetcode.com/problems/add-two-numbers/

func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
  guard var l1, var l2 else { return nil }

  var leftOver = (l1.val + l2.val) / 10
  let head = ListNode((l1.val + l2.val) % 10)
  var current = head

  while l1.next != nil || l2.next != nil {
    let value = (l1.next?.val ?? 0) + (l2.next?.val ?? 0) + leftOver

    let newNode = ListNode(value % 10)
    current.next = newNode
    current = newNode

    l1 = l1.next ?? l1
    l2 = l2.next ?? l2
    leftOver = value / 10
  }

  if leftOver > 0 {
    let newNode = ListNode(leftOver)
    current.next = newNode
    current = newNode
  }

  return head
}

addTwoNumbers([2, 4, 3].toListNode, [5, 6, 4].toListNode)?.toArray ?? []
addTwoNumbers([0].toListNode, [0].toListNode)?.toArray ?? []
addTwoNumbers([9, 9, 9, 9, 9, 9, 9].toListNode, [9, 9, 9, 9].toListNode)?.toArray ?? []
