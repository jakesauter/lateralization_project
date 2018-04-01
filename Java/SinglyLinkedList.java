// Implements a singly-linked list.

import java.util.Iterator;
import java.util.Scanner;

public class SinglyLinkedList implements Iterable<Object>
{
  private ListNode head;
  private int nodeCount;

  // Constructor: creates an empty list
  public SinglyLinkedList()
  {
    head = null;
    nodeCount = 0;
  }

  // Constructor: creates a list that contains
  // all elements from the array values, in the same order
  public SinglyLinkedList(Object[] values)
  {
    ListNode tail = null;
    for (Object value : values) // for each value to insert
    {
      ListNode node = new ListNode(value, null);
      if (head == null)
        head = node;
      else
        tail.setNext(node);
      tail = node;    // update tail
    }

    nodeCount = values.length;
  }

  // Returns true if this list is empty; otherwise returns false.
  public boolean isEmpty()
  {
    return nodeCount == 0;
  }

  // Returns the number of elements in this list.
  public int size()
  {
    return nodeCount;
  }

  // Returns true if this list contains an element equal to obj;
  // otherwise returns false.
  public boolean contains(Object obj)
  {
     return indexOf(obj) > -1;
  }

  // Returns the index of the first element in equal to obj;
  // if not found, returns -1.
  public int indexOf(Object obj)
  {
     int count = 0;
     for(ListNode node = head; node != null; node = node.getNext())
     {
        Object value = node.getValue();
         if(value.equals(obj))
            return count;
         count++;
     }
     return -1;
  }

  // Adds obj to this collection.  Returns true if successful;
  // otherwise returns false.
  public boolean add(Object obj)
  {
    if(isEmpty())
    {
        head = new ListNode(obj, null);
        nodeCount++;
        return true;
    }
    else if(!isEmpty())
    {
        ListNode tail = getTail();
        tail.setNext(null);
        tail.setValue(obj);
        tail = tail.getNext();
        nodeCount++;
        return true;
    }
    return false;
  }
  
  public ListNode getTail()
  {
      ListNode node = head;
        while(node.getNext() != null)
           node = node.getNext();
        ListNode tail = node.getNext();
        return tail;
    }

  // Removes the first element that is equal to obj, if any.
  // Returns true if successful; otherwise returns false.
  public boolean remove(Object obj)
  {
    if(indexOf(obj) != -1)
    {
        if(head.getValue().equals(obj))
        {
            head = head.getNext();
            //head.previous(null);
        }
        else if(getTail().getValue().equals(obj))
        {
            ListNode node = head;
            while(node.getNext().getNext() != null)
               node = node.getNext();
            ListNode newtail = node.getNext();
            newtail.setNext(null);
        }
        else
        {
            ListNode node = head;
            while(!node.getNext().equals(obj))
            {
                node = node.getNext();
            }
            node.setValue(obj);
            node.setNext(node.getNext());
        }
        nodeCount--;
        return true;
    }
    else
    {
        return false;
    }
  }

  // Returns the i-th element.               
  public Object get(int i)
  {
    int count = 0;
    ListNode node = head;
    while(node.getNext() != null && count != i)
    {
        node = node.getNext();
        count++;
    }
    return node.getValue();
  }

  // Replaces the i-th element with obj and returns the old value.
  public Object set(int i, Object obj)
  {
    Object oldvalue = get(i);
    ListNode node = head;
    int count = 0;
    while(node.getNext() != null && count != i)
    {
        node = node.getNext();
        count++;
    }
    node.setValue(obj);
    return oldvalue;
  }

  // Inserts obj to become the i-th element. Increments the size
  // of the list by one.
  public void add(int i, Object obj)
  {
      ListNode node = head;
      int count = 0; 
      
      if(i == 0)
      {
          head = new ListNode(obj, null);
        }
      else if(i == nodeCount)
      {
          ListNode tail = getTail();
        tail.setNext(null);
        tail.setValue(obj);
        tail = tail.getNext();
        }
      else
      {
      while(node.getNext() != null && count != i - 1)
      {
        node = node.getNext();
        count++;
      }
      ListNode addnode = node;
      addnode.setNext(node.getNext());
      addnode.setValue(obj);
      
      node.setNext(node.getNext());
    }
      nodeCount++;
  }
  
  public static void sort(ListNode head)
  {
      ListNode firstNode, node;
      
      for(firstNode = head; firstNode != null; firstNode = firstNode.getNext())
      {
         for(node = head; node != null; node = node.getNext())
         {
             String firstval = (String)(firstNode.getValue());
             String nodeval = (String)(node.getValue());
             if(firstval.compareToIgnoreCase(nodeval) < 0)
             {
                 String temp = firstval;
                 firstNode.setValue(nodeval);
                 node.setValue(temp);
             }
         }
      }
  }    
       

  // Removes the i-th element and returns its value.
  // Decrements the size of the list by one.
//   public Object remove(int i)
//   {
//       ListNode node = head;
//       int count = 0;
//       
//       if(i == 0)
//       {
//           head = node.getNext();
//       }
//       else if(i == nodeCount)
//       {
//          
//       }
//       else
//       {
//          while(node.getNext() != null && count != i)
//           {
//            node = node.getNext();
//            count++;
//           }
//        
//          ListNode remove = node.getNext();
//          node.setNext(node.getNext().getNext());
//        }
//       
//        nodeCount--;
//       return remove;
//   }

  // Returns a string representation of this list.
  public String toString()
  {
    ListNode node;
    String s = "";
   for(node = head; node != null; node = node.getNext())
    {
        s += node.getValue() + " ";
    }
    return s;
  }

  // Returns an iterator for this collection.
  public Iterator<Object> iterator()
  {
    return new SinglyLinkedListIterator(head);
  }
}
