
/**
 * Write a description of class DoubleTest here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
import java.util.NoSuchElementException;
public class DoubleTest
{
    public static void main()
    {
        //ListNode2 node1 = new ListNode2(7, null, null);;
        //ListNode2 node2 = new ListNode2(6, null, null);
        ListNode2 node3 = new ListNode2(4, null, null);
        ListNode2 node4 = new ListNode2(5, null, null);
        ListNode2 node5 = new ListNode2(0, null, null);
        
        //node1.setNext(node2);
        //node2.setPrevious(node1);
        //node2.setNext(node3);
       // node3.setPrevious(node2);
        node3.setNext(node4);
        node4.setPrevious(node3);
        node4.setNext(node5);
        node5.setPrevious(node4);
        
        ListNode2 newnode = removeMax(node3);
        ListNode2 temp;
        
       String s = "";
      for(temp = newnode; temp != null; temp = temp.getNext())
      {
          s += temp.getValue() + " ";
      }
       System.out.println(s);
    }
    
    public static ListNode2 removeMax(ListNode2 head)
    {
        if(head == null)
        {
            throw new NoSuchElementException();
        }
        
        ListNode2 temp;
        
        int count = 0, i = -1, max = (Integer)(head.getValue());
        for(temp = head; temp.getNext() != null; temp = temp.getNext())
        {
            i++;
            if(max < (Integer)(temp.getValue()))
            {
                count = i;
                max = (Integer)(temp.getValue());
                System.out.print("Max is: " + max);
                System.out.println(" Count " + count);
            }
        }
        
        ListNode2 node = head;
        for(int c = 0; c < count; c++)
        {
            node = node.getNext();
        }
        
        if(node.getPrevious() == null)
        {
            node = node.getNext();
        }
        else if(node.getNext() == null)
        {
            node = node.getPrevious();
        }
        else
        {
           node.getNext().setPrevious(node.getPrevious());
           node.getPrevious().setNext(node.getNext());
        }
        return node;
    }
    
    
}
