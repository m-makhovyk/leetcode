import Foundation

// MARK: - 2. Add Two Numbers [Medium]
// https://leetcode.com/problems/add-two-numbers/
// You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order, and each of their nodes contains a single digit.
// Add the two numbers and return the sum as a linked list.
// You may assume the two numbers do not contain any leading zero, except the number 0 itself.

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

// MARK: - 19. Remove Nth Node From End of List [Medium]
// https://leetcode.com/problems/remove-nth-node-from-end-of-list/
// Given the head of a linked list, remove the nth node from the end of the list and return its head.

func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
  // if there is only one element in the list, remove it
  guard head?.next != nil else { return nil }

  var count = 0

  // iterating through the list to get the total number of elements
  var current = head
  while current != nil {
    count += 1
    current = current!.next
  }

  var targetIndex = count - n
  // if target index is zero, skip first element
  if targetIndex == 0 {
    return head?.next
  }

  var index = 0
  current = head
  while current != nil {
    index += 1
    if index == targetIndex {
      current!.next = current!.next?.next
    } else {
      current = current!.next
    }
  }

  return head
}

removeNthFromEnd([1, 2, 3, 4, 5].toListNode, 2)?.toArray ?? []
removeNthFromEnd([1].toListNode, 1)?.toArray ?? []
removeNthFromEnd([1, 2].toListNode, 1)?.toArray ?? []

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

// MARK: - 24. Swap Nodes in Pairs [Medium]
// https://leetcode.com/problems/swap-nodes-in-pairs/
// Given a linked list, swap every two adjacent nodes and return its head.
// You must solve the problem without modifying the values in the list's nodes (i.e., only nodes themselves may be changed.)

func swapPairs(_ head: ListNode?) -> ListNode? {
  guard var current = head, current.next != nil else { return head }

  while let next = current.next {
    // swapping values without temp variable
    current.val += next.val
    next.val = current.val - next.val
    current.val -= next.val

    // hopping over the next node
    current = next.next ?? next
  }

  return head
}

swapPairs([1, 2, 3, 4].toListNode)?.toArray ?? []
swapPairs([1, 2, 3].toListNode)?.toArray ?? []
swapPairs([1].toListNode)?.toArray ?? []
swapPairs([].toListNode)?.toArray ?? []

// MARK: - 83. Remove Duplicates from Sorted List II [Medium]
// https://leetcode.com/problems/remove-duplicates-from-sorted-list-ii/
// Given the head of a sorted linked list, delete all nodes that have duplicate numbers, leaving only distinct numbers from the original list.
// Return the linked list sorted as well.

func deleteDuplicates(_ head: ListNode?) -> ListNode? {
  guard var head else { return nil }

  var previousNonDuplicate: ListNode?
  var duplicateCount = 0

  var current = head
  while let next = current.next {
    if current.val != next.val {

      // if it's the first element in the list, save it as the previous non-duplicate
      if previousNonDuplicate == nil && duplicateCount == 0 {
        previousNonDuplicate = current
      } else if duplicateCount != 0 {

        // if we have leading duplicates, drop them
        if previousNonDuplicate == nil {
          head = next
        } else {
          previousNonDuplicate?.next = current.next
        }

      } else {
        // meaning we have two consecutive non-duplicates
        previousNonDuplicate = current
      }

      duplicateCount = 0
    } else {
      // if current and next values are equal, increment the duplicate count
      duplicateCount += 1
    }


    current = next
  }

  // if all elements in list are duplicates, return nil
  // if only one element in the list, return it
  if previousNonDuplicate == nil {
    return head.val == head.next?.val ? nil : head
  }

  // drop trailing duplicates
  if duplicateCount != 0 {
    previousNonDuplicate?.next = nil
  }

  return head
}

deleteDuplicates([1, 2, 3, 3, 4, 4, 5].toListNode)?.toArray ?? []
deleteDuplicates([1, 1, 1, 2, 3].toListNode)?.toArray ?? []
deleteDuplicates([1, 1].toListNode)?.toArray ?? []
deleteDuplicates([1].toListNode)?.toArray ?? []
deleteDuplicates([1, 2, 2].toListNode)?.toArray ?? []

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

// MARK: - 234. Palindrome Linked List [Easy]
// https://leetcode.com/problems/palindrome-linked-list/
// Given the head of a singly linked list, return true if it is a palindrome or false otherwise.

func palindromeLinkedList(_ head: ListNode?) -> Bool {
  guard let head else { return true }

  // reversing the list to get the tail
  var current: ListNode? = head
  var tail: ListNode? = ListNode(head.val)

  while let next = current?.next {
    tail = ListNode(next.val, tail)
    current = next
  }

  // comparing the original list with the reversed one, for palindrome they should be the same
  current = head
  while tail != nil {
    if current!.val != tail!.val {
      return false
    }
    current = current!.next
    tail = tail!.next
  }

  return true
}

palindromeLinkedList([1, 2, 2, 1].toListNode)
palindromeLinkedList([1, 2].toListNode)

// MARK: - 876. Middle of the Linked List [Easy]
// https://leetcode.com/problems/middle-of-the-linked-list/
// Given the head of a singly linked list, return the middle node of the linked list. If there are two middle nodes, return the second middle node.

func middleNode(_ head: ListNode?) -> ListNode? {
  var current = head
  var count = 1

  while current != nil {
    count += 1
    current = current!.next
  }

  let middle = (count % 2) == 0 ? count / 2 : count / 2 + 1
  count = 0
  current = head
  while current != nil {
    count += 1
    if count == middle {
      return current
    }
    current = current!.next
  }

  return current
}

middleNode([1, 2, 3, 4, 5].toListNode)?.toArray ?? []
middleNode([1, 2, 3, 4, 5, 6].toListNode)?.toArray ?? []

// MARK: - 1290. Convert Binary Number in a Linked List to Integer [Easy]
// https://leetcode.com/problems/convert-binary-number-in-a-linked-list-to-integer/
// Given head which is a reference node to a singly-linked list. The value of each node in the linked list is either 0 or 1.
// The linked list holds the binary representation of a number.
// Return the decimal value of the number in the linked list.
// The most significant bit is at the head of the linked list.

func getDecimalValue(_ head: ListNode?) -> Int {
  guard let head else { return 0 }

  var current = head
  var tail: ListNode? = ListNode(head.val)

  // reversing the list
  while let next = current.next {
    let newNode = ListNode(next.val, tail)
    tail = newNode
    current = next
  }

  var value = 0
  var powValue: Double = 0
  while tail != nil {
    value += tail!.val * Int(pow(Double(2), powValue))
    powValue += 1
    tail = tail!.next
  }

  return value
}

getDecimalValue([1, 0, 1].toListNode)
getDecimalValue([0].toListNode)
