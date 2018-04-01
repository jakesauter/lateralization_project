
/**
 * Write a description of class LinkedListWithTail here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
import java.util.NoSuchElementException;
public class LinkedListWithTail
{
    private ListNode head;
    private ListNode tail;
    
    public LinkedListWithTail()
    {
        head = null;
        tail = null;
    }
    
    public LinkedListWithTail(ListNode h, ListNode t)
    {
        head = h;
        tail = t;
    }
    
    public boolean isEmpty()
    {
        return head == null;
    }
    
    public Object peek()
    {
        if(head == null)
        {
            throw new NoSuchElementException();
        }
        return head.getValue();
    }
    
    public boolean add(Object e)
    {
        ListNode newTail = new ListNode(e, null);
        
        if(head == null)
        {
            head = newTail;
            tail = newTail;
        }
        else
        {
            tail.setNext(newTail);
        }
        tail = newTail;
        return true;
    }
    
    public Object remove()
    {
        if(head == null)
        {
            throw new NoSuchElementException();
        }
        Object temp = head.getValue();
        head = head.getNext();
        if(head == null)
        {
            tail = null;
        }
        return temp;
    }
    
    public void append(LinkedListWithTail otherList)
    {
        if(head == null)
        {
            head = otherList.head;
        }
        else
        {
            tail.setNext(otherList.head);
        }
    }
    
    public String toString()
    {
       
       String s = "";
       for(ListNode node = head; node != null; node = node.getNext())
       {
          s += node.getValue() + " ";
       }
       return s;
    }
}

