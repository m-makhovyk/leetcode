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

// MARK: - 203. Remove Linked List Elements [Easy]
// https://leetcode.com/problems/remove-linked-list-elements/
// Given the head of a linked list and an integer val, remove all the nodes of the linked list that has Node.val == val, and return the new head.

func removeLinkedListElements(_ head: ListNode?, _ val: Int) -> ListNode? {
  guard var head else { return nil }

  var current = head
  while let next = current.next {
    // skip the next node if it has the value we want to remove
    if next.val == val {
      current.next = next.next
    } else {
      current = next
    }
  }
  // check if first node has the value we want to remove
  return head.val == val ? head.next : head
}

removeLinkedListElements([1, 2, 6, 3, 4, 5, 6].toListNode, 6)?.toArray ?? []
removeLinkedListElements([].toListNode, 1)?.toArray ?? []
removeLinkedListElements([7, 7, 7, 7].toListNode, 7)?.toArray ?? []

// MARK: - 83. Remove Duplicates from Sorted List [Easy]
// https://leetcode.com/problems/remove-duplicates-from-sorted-list/
// Given the head of a sorted linked list, delete all duplicates such that each element appears only once. Return the linked list sorted as well.

func removeDuplicatesFromSortedList(_ head: ListNode?) -> ListNode? {
  guard var head else { return nil }

  var storage: [Int: Int] = [:]
  var current: ListNode? = head

  // iterating thorugh the list to count the ocurrences of each value
  while current != nil {
    storage[current!.val, default: 0] += 1
    current = current!.next
  }

  current = head
  while current != nil {
    if storage[current!.val, default: 0] > 1 {
      current!.next = current!.next?.next
      storage[current!.val, default: 1] -= 1
    } else {
      current = current!.next
    }
  }

  return head
}

removeDuplicatesFromSortedList([1, 1, 2].toListNode)?.toArray ?? []
removeDuplicatesFromSortedList([1, 1, 2, 3, 3].toListNode)?.toArray ?? []

// MARK: - 21. Merge Two Sorted Lists [Easy]
// https://leetcode.com/problems/merge-two-sorted-lists/
// Merge two sorted linked lists and return it as a sorted list. The list should be made by splicing together the nodes of the first two lists.

func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
  if list1 == nil && list2 == nil { return nil }
  guard var list1 else { return list2 }
  guard var list2 else { return list1 }

  // dummy head to have something to attach the first
  var head = ListNode()
  var current = head

  while true {
    if list1.val < list2.val {
      let newNode = ListNode(list1.val)
      current.next = newNode
      current = newNode

      // in case we have reached the end of the first list, just append the rest of the second
      guard let next = list1.next else {
        current.next = list2
        current = list2
        break
      }
      list1 = next
    } else {
      let newNode = ListNode(list2.val)
      current.next = newNode
      current = newNode

      // in case we have reached the end of the second list, just append the rest of the first
      guard let next = list2.next else {
        current.next = list1
        current = list1
        break
      }
      list2 = next
    }
  }
  return head.next
}

mergeTwoLists([1, 2, 4].toListNode, [1, 3, 4].toListNode)?.toArray ?? []
mergeTwoLists([].toListNode, [].toListNode)?.toArray ?? []
mergeTwoLists([].toListNode, [0].toListNode)?.toArray ?? []


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
